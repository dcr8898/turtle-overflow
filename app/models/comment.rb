class Comment < ActiveRecord::Base
  belongs_to :user
  has_many :votes, as: :voteable
  belongs_to :commentable, polymorphic: true

  validates :body, :user, presence: true

  scope :most_voted, -> {
    order('votes_count DESC')
  }
  
end
