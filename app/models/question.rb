class Question < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :answer

  def self.random
    order('RANDOM()').first
  end

  def answer_is_correct?(string)
    string = string.strip.downcase
    answer = self.answer.strip.downcase

    return true if answer == string

    number_regexp = /(?!<\w)\d+(?!=\w)/
    numbers = []
    regexp = Regexp.escape(answer).gsub(number_regexp) do |match|
      numbers << Integer(match)
      '(.*)'
    end

    matches = Regexp.new("\\A#{regexp}\\z").match(string)
    return false unless matches

    numbers.map.with_index do |number, i|
      matched = matches[1 + i]
      number.to_s == matched || number.to_words == matched
    end.all?
  end
end
