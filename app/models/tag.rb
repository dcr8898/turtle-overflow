class Tag < ActiveRecord::Base
  has_many :questions_tags
  has_many :question, through: :questions_tags

  validates :text, presence: true
end
