class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_many   :comments, as: :commentable
  has_many   :votes, as: :voteable

  validates :body, :user, :question, presence: true

  scope :most_voted, -> {
    order('votes_count DESC')
  }
  
end
