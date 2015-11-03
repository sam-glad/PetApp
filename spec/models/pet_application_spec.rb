require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  context 'Validations' do
    describe 'name' do
       subject { FactoryGirl.create(:pet_application) }
       it { should validate_presence_of(:user) }
       it { should validate_presence_of(:pet) }
       it { should validate_presence_of(:organization) }
       it { should validate_presence_of(:status) }
       it { should validate_presence_of(:questions) }
    end
  end

  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:pet) }
    it { should belong_to(:organization) }
    it { should have_many(:questions) }
  end
end
