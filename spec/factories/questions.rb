FactoryGirl.define do
  factory :question do
    sequence(:body) { |n| "Is this question \##{n}?" }
    sequence(:application_form) { FactoryGirl.create(:application_form) }
  end
end
