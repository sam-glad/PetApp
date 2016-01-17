class User < ActiveRecord::Base
  has_many :organization_memberships
  has_many :organizations, :through => :organization_memberships

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  ###### Methods concerning permissions ######

  def can_view_all_pet_applications?(organization_id)
    organization_membership = find_organization_membership(organization_id)
    return !organization_membership.nil? ? organization_membership.can_view_all_applications : false
  end

  def can_view?(pet_application)
    organization_membership = find_organization_membership(pet_application.organization_id)
    return !organization_membership.nil? ?
      organization_membership.can_view_all_applications :
      self.id == pet_application.user_id
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
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications and Pets allowed')
    end
  end

  def can_delete?(pet_application)
    organization_membership = find_organization_membership(pet_application.organization_id)
    return !organization_membership.nil? ?
      organization_membership.can_delete_all_applications :
      self.id == pet_application.user_id
  end

  def find_organization_membership(organization_id)
    return OrganizationMembership.find_by(organization_id: organization_id, user_id: self.id)
  end
end
