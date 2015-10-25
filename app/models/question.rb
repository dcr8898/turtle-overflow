class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer
  has_many   :answers
  has_and_belongs_to_many   :tags
  has_many   :comments, as: :commentable
  has_many   :votes, as: :voteable

  validates :title, :body, :user, presence: true

  scope :most_voted, -> {
    order('votes_count DESC')
  }

  def add_tags(tag_string)
    tag_array = tag_string.split(", ").map {
      |tag| Tag.where(text: tag).first_or_create
    }
    self.tags = tag_array
  end

end
