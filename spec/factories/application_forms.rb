FactoryGirl.define do
  factory :application_form do
    sequence(:name) { |n| "Application form #{n}" }
  end
end
