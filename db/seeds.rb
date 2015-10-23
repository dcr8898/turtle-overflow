# Users
print "Creatings users . . . "
users = Array.new(50) { Faker::Internet.user_name }.uniq
25.times do |i|
    User.create(username: users[i],
                password: users[i])
end
puts "Done!"
user_ids = User.ids

# Questions
print "Creatings questions . . . "
500.times do |i|
  created_at = Faker::Time.backward(730)
  updated_at = created_at
  updated_at += rand(30) if (created_at + 30) < DateTime.now
  Question.create(title:      Faker::Hacker.say_something_smart,
                  body:       Faker::Lorem.paragraph,
                  user_id:    user_ids.sample,
                  created_at: created_at,
                  updated_at: updated_at)
end
puts "Done!"
question_ids = Question.ids

# Answers
print "Creatings answers . . . "
10000.times do |i|
  question = Question.find(question_ids.sample)
  created_at = question.created_at + rand(14)
  updated_at = created_at
  updated_at += rand(10) if (created_at + 10) < DateTime.now
  Answer.create(body:       Faker::Lorem.paragraph,
                user_id:    user_ids.sample,
                question:   question,
                created_at: created_at,
                updated_at: updated_at)
end
puts "Done!"
answer_ids = Answer.ids

# Comments
puts "Creatings comments . . . "
commentables = [[Question, question_ids],
                [Answer,   answer_ids  ]]
50000.times do |i|
  comment_type     = commentables.sample
  commentable_id   = comment_type[1].sample
  commentable_type = comment_type[0].name
  created_at       = commentable.created_at + rand(14)
  updated_at       = created_at
  updated_at      += rand(10) if (created_at + 10) < DateTime.now
  Comment.create(body:             Array.new(3) {
                                     Faker::Hacker.say_something_smart
                                   }.join(" "),
                 user_id:          user_ids.sample,
                 commentable_id:   commentable_id,
                 commentable_type: commentable_type,
                 created_at:       created_at,
                 updated_at:       updated_at)
  puts "#{i + 1} of 50,000 done" if (i + 1) % 10000 == 0
end
comment_ids = Comment.ids

# Votes
puts "Creatings votes . . . "
voteables = [[Question, 'Question', question_ids],
             [Answer,   'Answer',   answer_ids  ],
             [Comment,  'Comment',  comment_ids ]]
vote_values = [1, -1]
100000.times do |i|
  vote_type     = voteables.sample
  voteable_id   = vote_type[1].sample
  voteable_type = vote_type[0].name
  Vote.create(value:           vote_values.sample,
              user_id:         user_ids.sample,
              voteable_id:     voteable_id,
              voteable_type:   voteable_type)
  puts "#{i + 1} of 100,000 done" if (i + 1) % 10000 == 0
end

# Tags
print "Creatings tags . . . "
lorem = Array.new(1000) { Faker::Lorem.word }.uniq
500.times do |i|
  Tag.create(text: lorem[i])
end
puts "Done!"
tag_ids = Tag.ids

#Add randomized tags to Questions aand select answer for 80% of Questions
print "Adding 'selected answer' and tags to questions . . . "
Questions.all.each do |question|
  num_tags = rand(6)
  tag_ids.sample(num_tags).each do |tag_id|
    question.tags << Tag.find(tag_id)
  end
  if rand < 0.8
    question.answer = question.answers.sample
  end
end
puts "Done!"
