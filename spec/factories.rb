FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password  "password"
  end

  factory :question do
    title { Faker::Hacker.ingverb + " " + Faker::Book.title }
    body { Faker::Lorem.paragraph }
    association :user
    answer nil

    factory :answered_question do
      association :answer
    end
  end

  factory :tag do
    text {Faker::Hacker.noun}
  end

  factory :answer do
    body { Faker::Hacker.say_something_smart }
    association :user
    association :question
  end

  factory :comment do
    body { Faker::Company.bs }
    association :user
    association :question
    
    factory :answer_comment do
      commentable "Answer" 
    end
  end

end