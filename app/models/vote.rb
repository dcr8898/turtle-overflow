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

  def update_vote_count
    self.voteable.votes_count = self.total_votes
    self.voteable.save
  end

end
