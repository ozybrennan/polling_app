# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base

  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_answer_own_question

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question
  has_one :poll, through: :question, source: :poll

  # has_one
  # delegate :poll, to: :question

  def sibling_responses
    if self.id
      self.question.responses.where("responses.id != ?", self.id)
    else
      self.question.responses
    end
  end

  private

  def respondent_has_not_already_answered_question
    if self.sibling_responses.where("responses.user_id = ?", self.user_id).size > 0
      errors[:user_id] << "cannot answer same question twice"
    end
  end

  def respondent_cannot_answer_own_question
    if self.poll.author_id == self.user_id
      errors[:user_id] << "cannot answer own question"
    end
  end

end
