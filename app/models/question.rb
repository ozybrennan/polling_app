# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base

  validates :text, presence: true
  validates :poll_id, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  # def results
  #   results = {}
  #   self.answer_choices.includes(:responses).each do |answer_choice|
  #     results[answer_choice.text] = answer_choice.responses.length
  #   end
  #   results
  # end

  def results
    answerc = self
    .answer_choices
    .joins("LEFT OUTER JOIN responses ON answer_choice_id = answer_choices.id")
    .where("question_id = ?", self.id)
    .group(:text)
    .select("answer_choices.text, count(user_id) AS response_count")
    results = {}
    answerc.each { |query| results[query.text] = query.response_count }
    results
    # AnswerChoice.find_by_sql(<<-SQL)
    # SELECT ac.text, COUNT(*) count
    # FROM answer_choices ac
    # JOIN responses r ON r.answer_choice_id = ac.id
    # WHERE ac.question_id = #{self.id}
    # GROUP BY ac.text
    # SQL
  end

end
