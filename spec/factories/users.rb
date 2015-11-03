FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Example User#{n}" }
    sequence(:email) { |n| "exampleuser#{n}@example.com" }
    password '12345678'
    password_confirmation '12345678'
  end
end
