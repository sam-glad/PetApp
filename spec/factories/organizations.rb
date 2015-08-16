FactoryGirl.define do
  factory :organization do
    sequence(:name) { |n| "Saint Bernard Rescue #{n}" }
  end

end
