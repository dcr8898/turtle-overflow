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
    association :commentable, factory: :question
    
    factory :answer_comment do
      association :commentable, factory: :answer 
    end
  end

  factory :vote do
    value [1, -1].sample
    association :user
    association :voteable, factory: :question

    factory :answer_vote do
      association :voteable, factory: :answer
    end
  end


end