FactoryGirl.define do
  factory :application_form do
    sequence(:name) { |n| "Application form #{n}" }
    sequence(:organization_id) { |n| n }
  end
end
