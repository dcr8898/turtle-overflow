class QuestionTag < ActiveRecord::Base
  has_many :questions
  has_many :tags
end
