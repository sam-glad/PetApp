FactoryGirl.define do
  factory :pet_application do
    status 0 # TODO: Replace this with a working enum
    application_type 0 # TODO: Replace this with a working enum

    after(:build) do |pet_application|
      pet = FactoryGirl.create(:pet)
      pet_application.pet = pet
      pet_application.organization = pet.organization
      pet_application.user = FactoryGirl.create(:user)
      pet_application.questions << FactoryGirl.build(:question)
    end
  end
end
