class Tag < ActiveRecord::Base
  has_and_belongs_to_many :questions

  validates :text, presence: true

  def self.tags_text
    self.all.pluck(:text).join(', ')
  end
end
