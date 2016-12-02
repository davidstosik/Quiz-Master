class Question < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :answer

  def answer_is_correct?(answer)
    return true if answer.downcase == self.answer.downcase
    # TODO number to words
  end
end
