# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base

  validates :user_name, presence: true

  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id
  )
=begin
  SELECT
    p.id, COUNT(r.id)
  FROM
    polls p
  JOIN questions q ON q.poll_id = p.id
  JOIN answer_choices ac ON ac.question_id = q.id
  LEFT OUTER JOIN responses r ON r.answer_choice_id = ac.id
  WHERE
    r.user_id = 1
  GROUP BY
    p.id
  HAVING COUNT(r.id) = COUNT(q.id)
=end

  def completed_polls
    # responses.eager_load(:poll).select('COUNT() AS count')
    # poll = Poll.find(2)
    # question_count = poll.questions.length #count questions in poll
    Poll.joins(:questions => {:answer_choices => :responses}).where('polls.id = 2 AND responses.user_id = 1').group('polls.id').select("COUNT(responses.id) AS count")
    Response.joins(:answer_choice => {:question => :poll}).where('polls.id = 2 AND responses.user_id = 1').group('responses.id').select("COUNT(responses.id) AS count")
  end
end
