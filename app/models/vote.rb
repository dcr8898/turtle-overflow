class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user, presence: true

  validates :value, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: [:voteable_type, :voteable_id], message: "You have already voted." }

  after_save :update_vote_count

  def total_votes
    self.voteable.votes.sum(:value)
  end 

  def unchosen_answers
    if self.answer
      self.answers.where.not(id: self.answer.id).order('votes_count desc')  
    else
      self.answers
    end
  end

end
