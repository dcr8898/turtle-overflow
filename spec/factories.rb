FactoryGirl.define do
  factory :user do
    username "johndoe"
    password  "johndoe"
  end

  factory :question do
    title { Faker::Hacker.ingverb + " " + Faker::Book.title }
    body { Faker::Lorem.paragraph }
    association :user
    answer "nil"

    factory :answered_question do
      association :answer
    end
  end

  factory :tag do
    text {Faker::Hacker.noun}
  end

  factory :answer do
    text { Faker::Hacker.say_something_smart }
    association :user
    association :question
  end

  factory :question_comment do
    text { Faker::Company.bs }
    association :user
    commentable "Question"
    
    factory :answer_comment do
      commentable "Answer" 
    end
  end
end