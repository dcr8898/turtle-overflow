# Users
users = Array.new(50) { Faker::Internet.user_name }.uniq
25.times do |i|
    User.create(username: users[i],
                password: users[i])
end
user_ids = User.ids

# Questions
500.times do |i|
  created_at = Faker::Time.backward(730)
  updated_at = created_at
  updated_at += rand(30) if (created_at + 30) < DateTime.now
  Question.create(title:      Faker::Hacker.say_something_smart,
                  body:       Faker::Lorem.paragraph,
                  user:       User.find(user_ids.sample)
                  created_at: created_at,
                  updated_at: updated_at)
end
question_ids = Question.ids

# Answers
10000.times do |i|
  question = Question.find(question_ids.sample)
  created_at = question.created_at + rand(14)
  updated_at = created_at
  updated_at += rand(10) if (created_at + 10) < DateTime.now
  Answer.create(body:       Faker::Lorem.paragraph,
                user:       User.find(user_ids.sample),
                question:   question,
                created_at: created_at,
                updated_at: updated_at)
end
answer_ids = Answer.ids

# Comments
commentables = [[Question, question_ids],
                [Answer,   answer_ids]]
50000.times do |i|
  comment_type = commentables.sample
  commentable  = comment_type[0].find(comment_type[1].sample)
  created_at   = commentable.created_at + rand(14)
  updated_at   = created_at
  updated_at  += rand(10) if (created_at + 10) < DateTime.now
  Comment.create(body:        Array.new(3) {
                                Faker::Hacker.say_something_smart
                              }.join(" "),
                 user:        User.find(user_ids.sample)
                 commentable: commentable,
                 created_at:  created_at,
                 updated_at:  updated_at)
end
comment_ids = Comment.ids

# Votes
voteables = [[Question, question_ids],
             [Answer,   answer_ids  ],
             [Comment,  comment_ ids ]]
vote_values = [1, -1]
100000.times do |i|
  vote_type    = voteables.sample
  voteable     = vote_type[0].find(vote_type[1].sample)
  Vote.create(value:      vote_values.sample,
              user:       User.find(user_ids.sample),
              voteable:   voteable)
end

# Tags
lorem = Array.new(1000) { Faker::Lorem.word }.uniq
500.times do |i|
  Tag.create(text: lorem[i])
end
tag_ids = Tag.ids

#Add randomized tags to Questions aand select answer for 80% of Questions
Questions.all.each do |question|
  num_tags = rand(6)
  tag_ids.sample(num_tags).each do |tag_id|
    question.tags << Tag.find(tag_id)
  end
  if rand < 0.8
    question.answer = question.answers.sample
  end
end
