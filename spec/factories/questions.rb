FactoryGirl.define do
  factory :question do
    sequence(:body) { |n| "Is this question \##{n}?" }
    sequence(:application_form_id) { |n| n }
  end
end
