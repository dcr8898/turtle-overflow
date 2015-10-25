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
    tag_string = "" if tag_string.nil?
    tag_array = tag_string.strip.split(", ").map {
      |tag| Tag.where(text: tag).first_or_create
    }
    self.tags = tag_array
  end

  def tags_text
    self.tags.tags_text
  end

  def unchosen_answers
    if self.answer
      self.answers.where.not(id: self.answer.id).order('votes_count desc')
    else
      self.answers
    end
  end

end
