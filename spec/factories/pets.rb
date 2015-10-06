FactoryGirl.define do
  factory :pet do
    animal 'Dog'
    is_mix? false
    age 'Young'
    sequence(:name) { |n| "Doggie\##{n}" }
    size 'XL'
    sex 'M'
    description 'A description'
    status 'Adoptable'
    good_with_dogs true
    good_with_cats false
    good_with_kids false
    breeds [FactoryGirl.create(:breed)]
  end
end
