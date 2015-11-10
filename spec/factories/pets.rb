FactoryGirl.define do
  factory :pet do
    animal 'Dog'
    is_mix? false
    age 'Young'
    sequence(:name) { |n| "Doggie\##{n}" }
    size 'XL'
    sex 'M'
    description 'A description'
    status 0
    good_with_dogs true
    good_with_cats false
    good_with_kids false
    after(:build) { |pet| pet.breeds << FactoryGirl.create(:breed) }
    after(:build) { |pet| pet.organization = FactoryGirl.create(:organization) }
  end
end
