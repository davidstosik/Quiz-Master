FactoryGirl.define do
  factory :question do
    sequence :body do |n|
      "How many letters are there in the English alphabet? (#{n})"
    end
    answer '26'
  end
end
