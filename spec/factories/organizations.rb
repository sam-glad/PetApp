FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "Saint Bernard Rescue #{n}" }
    city 'Worcester'
    state_province 'Massachusetts'
    phone_number '5081234567'
    phone_extension '90'
    country 'United States'
    sequence(:website) { |n| "http://www.example.com/worcestersaints#{n}" }
    sequence(:email_address) { |n| "worcestersaints#{n}@example.com" }
    phone_preferred false
  end
end
