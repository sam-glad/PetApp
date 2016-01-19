class User < ActiveRecord::Base
  has_many :organization_memberships
  has_many :organizations, :through => :organization_memberships

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  ###### Methods concerning permissions ######

  AUTHORIZATION_ARGUMENT_ERROR_MESSAGE = 'Wrong type passed - only PetApplications and Pets allowed'

  def can_create?(model)
    organization_membership = find_organization_membership(model.organization_id)
    return false if organization_membership.nil? # TODO: Add this check to other authorization methods!!!
    case model
      when ApplicationForm
        return (!organization_membership.nil? && organization_membership.can_manage_application_forms)
      else
        # TODO: Is this the right error message for this? Double check
        raise ArgumentError.new(AUTHORIZATION_ARGUMENT_ERROR_MESSAGE)
    end
  end

  def can_view_all_pet_applications?(organization_id)
    organization_membership = find_organization_membership(organization_id)
    return !organization_membership.nil? ? organization_membership.can_view_all_applications : false
  end

  def can_view?(model)
    organization_membership = find_organization_membership(model.organization_id)
    case model
      when PetApplication
        pet_application = model
        return !organization_membership.nil? ?
          organization_membership.can_view_all_applications :
          self.id == pet_application.user_id
      when ApplicationForm
        application_form = model
        return (!organization_membership.nil? && organization_membership.can_manage_application_forms)
      else
        raise ArgumentError.new(AUTHORIZATION_ARGUMENT_ERROR_MESSAGE)
    end
  end

  # This is already getting way too busy
  # TODO: Separate class-specific logic (conditions) into individual methods
  def can_edit?(model)
    organization_membership = find_organization_membership(model.organization_id)
    case model
      when PetApplication
        pet_application = model
        return !organization_membership.nil? ?
          organization_membership.can_edit_all_applications :
          self.id == pet_application.user_id
      when Pet
        return (!organization_membership.nil? && organization_membership.can_edit_all_pets)
      when ApplicationForm
        return (!organization_membership.nil? && organization_membership.can_manage_application_forms)
      else
        raise ArgumentError.new(AUTHORIZATION_ARGUMENT_ERROR_MESSAGE)
    end
  end

  def can_delete?(model)
    organization_membership = find_organization_membership(model.organization_id)
    case model
      when PetApplication
        pet_application = model
        return !organization_membership.nil? ?
          organization_membership.can_delete_all_applications :
          self.id == pet_application.user_id
      when ApplicationForm
        return (!organization_membership.nil? && organization_membership.can_manage_application_forms)
      else
        raise ArgumentError.new(AUTHORIZATION_ARGUMENT_ERROR_MESSAGE)
    end
  end

  def find_organization_membership(organization_id)
    return OrganizationMembership.find_by(organization_id: organization_id, user_id: self.id)
  end
end
