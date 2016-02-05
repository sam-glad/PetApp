require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  # def user
  #   return FactoryGirl.create(:user)
  # end

  let(:organization) { FactoryGirl.create(:organization) }

  # def organization
  #   return FactoryGirl.create(:organization)
  # end

  def create_organization_membership(user, is_admin = false)
    return OrganizationMembership.create(user_id: user.id, organization_id: organization.id, is_admin: is_admin)
  end

  let(:admin_organization_membership) { OrganizationMembership.create(user_id: user.id, organization_id: organization.id, is_admin: true) }

  # def application_form
  #   ApplicationForm.new(organization: organization, user: user)
  # end

  let(:application_form) { ApplicationForm.new(organization: organization) }

  context 'Validations' do
  end

  context 'Associations' do
    it { should have_many(:organization_memberships) }
    it { should have_many(:organizations).through(:organization_memberships) }
  end

  # TODO: Clean up the way the tests are worded when they fail
  context 'permissions:' do
    context 'can create' do
      it 'returns false when the user is not in the organization' do
        # No organization_membership
        expect(user.can_create?(application_form)).to eq(false)
      end

      it 'returns false with another type of model' do
        # No organization_membership
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
  end
end
