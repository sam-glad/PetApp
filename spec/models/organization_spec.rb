require 'rails_helper'

describe Organization do
  context 'Validations' do
    describe 'name' do
       subject { FactoryGirl.create(:organization) }
       it { should validate_presence_of(:name) }
       it { should validate_uniqueness_of(:name) }
       it { should validate_length_of(:name).is_at_least(2).is_at_most(80) }
       it { should validate_presence_of(:city) }
       it { should validate_presence_of(:state_province) }
       it { should validate_presence_of(:country) }
       it { should validate_uniqueness_of(:website) }
       it { should allow_value(' ').for(:website) }
       it { should allow_value(nil).for(:website) }
       it { should validate_uniqueness_of(:email_address) }
       it { should allow_value(' ').for(:email_address) }
       it { should allow_value(nil).for(:email_address) }
    end
  end

  context 'Associations' do
    it { should have_many(:organization_memberships) }
    it { should have_many(:users).through(:organization_memberships) }
  end
end
