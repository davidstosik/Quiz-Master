class Question < ApplicationRecord
  validates_presence_of :body
  validates_presence_of :answer
end
