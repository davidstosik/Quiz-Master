FactoryGirl.define do
  factory :question do
    sequence :title do |n|
      "English alphabet (#{n})"
    end
    sequence :body do |n|
      "How many letters are there in the English alphabet? (#{n})"
    end
    answer 'answer-26'
  end
end
