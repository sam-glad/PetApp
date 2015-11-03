FactoryGirl.define do
  factory :question do
    sequence(:body) { |n| "Is this question \##{n}?" }
    input_type 0 # TODO: Replace with enum
  end
end
