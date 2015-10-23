class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user, presence: true

  validates :value, numericality: { only_integer: true }
  validates :value, uniqueness: { scope: :user_id, message: "You have already voted." }
end
