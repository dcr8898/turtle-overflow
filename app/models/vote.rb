class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voteable, polymorphic: true, counter_cache: true

  validates :user, presence: true

  validates :value, numericality: { only_integer: true }
  validates :user_id, uniqueness: { scope: [:voteable_type, :voteable_id], message: "You have already voted." }

end
