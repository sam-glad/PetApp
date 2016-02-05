require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:organization) { FactoryGirl.create(:organization) }
  let(:application_form) { ApplicationForm.new(organization: organization) }

  def create_organization_membership(user, is_admin = false)
    return OrganizationMembership.create(user_id: user.id, organization_id: organization.id, is_admin: is_admin)
  end

  context 'Validations' do
  end

  context 'Associations' do
    it { should have_many(:organization_memberships) }
    it { should have_many(:organizations).through(:organization_memberships) }
  end

  # TODO: Clean up the way the tests are worded when they fail
  context 'permissions:' do
    context 'can_create?' do
      it 'returns false when the user is not in the organization' do
        # No organization_membership
        expect(user.can_create?(application_form)).to eq(false)
      end

      it 'raises an ArgumentError with the wrong model' do
        pet = FactoryGirl.build(:pet)
        expect{user.can_create?(pet).to raise_error(ArgumentError, 'Wrong type passed - only ApplicationForms allowed')}
      end

      it 'returns false when is_admin is false' do
        create_organization_membership(user, false)
        expect(user.can_create?(application_form)).to eq(false)
      end

      it 'returns false when is_admin is true' do
        create_organization_membership(user, true)
        expect(user.can_create?(application_form)).to eq(true)
      end
    end

    context 'can_view?' do
      it 'raises an ArgumentError with the wrong model' do
        pet = FactoryGirl.create(:pet)
        expect{user.can_create?(pet).to raise_error(ArgumentError, 'Wrong type passed - only PetApplications and ApplicationForms allowed')}
      end

      context 'application forms' do
        it 'returns false when the user is not in the organization' do
          # No organization_membership
          expect(user.can_view?(application_form)).to eq(false)
        end
      end

      context 'pet applications' do
        it 'returns true if the user owns the pet application' do
          # No organization_membership
          pet_application = PetApplication.new(user: user)
          expect(user.can_view?(pet_application)).to eq(true)
        end
      end
    end
  end
end
