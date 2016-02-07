require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  let(:organization) { FactoryGirl.create(:organization) }
  let(:application_form) { ApplicationForm.new(organization: organization) }
  let(:pet) { Pet.new(organization: organization) }
  let(:question) { FactoryGirl.create(:question) }

  def create_organization_membership(user, is_admin = false)
    return OrganizationMembership.create(user_id: user.id, organization_id: organization.id, is_admin: is_admin)
  end

  context 'Validations' do
  end

  context 'Associations' do
    it { should have_many(:organization_memberships) }
    it { should have_many(:organizations).through(:organization_memberships) }
  end

  context 'as_json' do
    it 'should merge the default serialized user (from AMS) with result from custom serializer' do
      expect(user.as_json()).to eq(UserSerializer.new(user).as_json[:user])
    end
  end

  context 'find_organization_membership' do
    it 'should find an OrganizationMembership when the model has an organization_id column' do
      create_organization_membership(user, true)
      expect(user.find_organization_membership(application_form)).to be_an_instance_of(OrganizationMembership)
    end

    it 'should return nil when no OrganizationMembership exists' do
      # No OrganizationMembership linking user and application_form
      expect(user.find_organization_membership(application_form)).to be(nil)
    end

    it 'should return nil when the model does not have an organization_id column' do
      expect(user.find_organization_membership(application_form)).to be(nil)
    end
  end

  # TODO: Clean up the way the tests are worded when they fail
  context 'permissions:' do
    context 'can_create?' do
      it 'raises an ArgumentError with the wrong model' do
        expect{user.can_create?(question)}.to raise_error(ArgumentError, 'Wrong type passed - only ApplicationForms allowed')
      end

      it 'returns false when the user is not in the organization' do
        # No organization_membership
        expect(user.can_create?(application_form)).to eq(false)
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
        expect{user.can_view?(question)}.to raise_error(ArgumentError, 'Wrong type passed - only PetApplications and ApplicationForms allowed')
      end

      context 'application forms' do
        it 'returns false when the user is not in the organization' do
          # No organization_membership
          expect(user.can_view?(application_form)).to eq(false)
        end

        it 'returns false when the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          expect(user.can_view?(application_form)).to eq(false)
        end

        it 'returns true when the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          expect(user.can_view?(application_form)).to eq(true)
        end
      end

      context 'pet applications' do
        it 'returns true if the user owns the pet application' do
          # No organization_membership
          pet_application = PetApplication.new(user: user)
          expect(user.can_view?(pet_application)).to eq(true)
        end

        it 'returns false if the user does not own the pet application and has no admin privileges' do
          # No organization_membership
          pet_application = PetApplication.new(user: other_user)
          expect(user.can_view?(pet_application)).to eq(false)
        end

        it 'returns true if the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          pet_application = PetApplication.new(user: user)
          expect(user.can_view?(pet_application)).to eq(true)
        end

        it 'returns false if the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          pet_application = PetApplication.new(user: other_user)
          expect(user.can_view?(pet_application)).to eq(false)
        end
      end
    end

    context 'can_update?' do
      it 'raises an ArgumentError with the wrong model' do
        expect{user.can_update?(question)}.to raise_error(ArgumentError, 'Wrong type passed - only PetApplications, Pets, and ApplicationForms allowed')
      end

      context 'application forms' do
        it 'returns false when the user is not in the organization' do
          # No organization_membership
          expect(user.can_update?(application_form)).to eq(false)
        end

        it 'returns true when the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          expect(user.can_update?(application_form)).to eq(true)
        end

        it 'returns false when the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          expect(user.can_update?(application_form)).to eq(false)
        end
      end

      context 'pets' do
        it 'returns false when the user is not in the organization' do
          # No organization_membership
          expect(user.can_update?(pet)).to eq(false)
        end

        it 'returns false when the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          expect(user.can_update?(pet)).to eq(false)
        end

        it 'returns true when the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          expect(user.can_update?(pet)).to eq(true)
        end
      end

      context 'pet applications' do
        it 'returns true if the user owns the pet application' do
          # No organization_membership
          pet_application = PetApplication.new(user: user)
          expect(user.can_update?(pet_application)).to eq(true)
        end

        it 'returns false if the user does not own the pet application and has no admin privileges' do
          # No organization_membership
          pet_application = PetApplication.new(user: other_user)
          expect(user.can_update?(pet_application)).to eq(false)
        end

        it 'returns true if the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          pet_application = PetApplication.new(user: user)
          expect(user.can_update?(pet_application)).to eq(true)
        end

        it 'returns false if the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          pet_application = PetApplication.new(user: other_user)
          expect(user.can_update?(pet_application)).to eq(false)
        end
      end
    end

    context 'can_delete?' do
      it 'raises an ArgumentError with the wrong model' do
        expect{user.can_delete?(question)}.to raise_error(ArgumentError, 'Wrong type passed - only PetApplications and ApplicationForms allowed')
      end

      context 'application forms' do
        it 'returns false when the user is not in the organization' do
          # No organization_membership
          expect(user.can_delete?(application_form)).to eq(false)
        end

        it 'returns true when the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          expect(user.can_delete?(application_form)).to eq(true)
        end

        it 'returns false when the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          expect(user.can_delete?(application_form)).to eq(false)
        end
      end

      context 'pet applications' do
        it 'returns true if the user owns the pet application' do
          # No organization_membership
          pet_application = PetApplication.new(user: user)
          expect(user.can_delete?(pet_application)).to eq(true)
        end

        it 'returns false if the user does not own the pet application and has no admin privileges' do
          # No organization_membership
          pet_application = PetApplication.new(user: other_user)
          expect(user.can_delete?(pet_application)).to eq(false)
        end

        it 'returns true if the user is in the organization with admin privileges' do
          create_organization_membership(user, true)
          pet_application = PetApplication.new(user: user)
          expect(user.can_delete?(pet_application)).to eq(true)
        end

        it 'returns false if the user is in the organization without admin privileges' do
          create_organization_membership(user, false)
          pet_application = PetApplication.new(user: other_user)
          expect(user.can_delete?(pet_application)).to eq(false)
        end
      end
    end

  end
end
