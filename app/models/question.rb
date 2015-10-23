class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  has_many   :answers
  has_and_belongs_to_many   :tags
  has_many   :comments, as: :commentable
  has_many   :votes, as: :voteable

  validates :title, :body, :user, presence: true
end
