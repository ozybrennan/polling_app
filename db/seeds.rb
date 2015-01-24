# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(user_name: "Santa Claus")
User.create(user_name: "the Easter Bunny")
Poll.create(title: "Christmas poll", author_id: User.first.id)
Poll.create(title: "Easter poll", author_id: User.last.id)
q1 = Question.create(text: "favorite presents?", poll_id: Poll.first.id)
AnswerChoice.create(text: "Ruby books", question_id: q1.id)
AnswerChoice.create(text: "Dalmations", question_id: q1.id)
q2 = Question.create(text: "least favorite presents?", poll_id: Poll.first.id)
AnswerChoice.create(text: "socks", question_id: q2.id)
AnswerChoice.create(text: "sweaters", question_id: q2.id)
q3 = Question.create(text: "best holiday?", poll_id: Poll.last.id)
AnswerChoice.create(text: "Christmas", question_id: q3.id)
AnswerChoice.create(text: "Easter", question_id: q3.id)
q4 = Question.create(text: "isn't anyone going to answer Easter?", poll_id: Poll.last.id)
AnswerChoice.create(text: "Yes", question_id: q4.id)
AnswerChoice.create(text: "No", question_id: q4.id)
Response.create(user_id: 1, answer_choice_id: 5)
Response.create(user_id: 1, answer_choice_id: 8)
