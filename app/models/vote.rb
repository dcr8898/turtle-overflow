class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user, presence: true

  validates :vote, numericality: { only_integer: true }
  validates :vote, uniqueness: { scope: :user_id, message: "You have already voted." }
end
