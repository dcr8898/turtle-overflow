# Users
users = Array.new(50) { Faker::Internet.user_name }.uniq
25.times do |i|
    User.create(username: users[i],
                email:    Faker::Internet.email(users[1])
                password: users[i])
end

# Questions
500.times do |i|
  created_at = Faker::Time.backward(730)
  updated_at = created_at
  updated_at += rand(30) if (created_at + 30) < DateTime.now
  Question.create(title:      Faker::Hacker.say_something_smart,
                  body:       Faker::Lorem.paragraph,
                  created_at: created_at,
                  updated_at: updated_at)
end

# Answers
question_ids = Question.ids
10000.times do |i|
  question = Question.find(question_ids.sample)
  created_at = question.created_at + rand(14)
  updated_at = created_at
  updated_at += rand(10) if (created_at + 10) < DateTime.now
  Answer.create(body:       Array.new(3) {
                              Faker::Hacker.say_something_smart
                            }.join(" "),
                created_at: created_at,
                updated_at: updated_at)
end
