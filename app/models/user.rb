class User < ActiveRecord::Base
  has_many :organization_memberships
  has_many :organizations, through: :organization_memberships

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  # Override so JS can check for permissions
  def as_json(options = {})
    return UserSerializer.new(self).as_json[:user]
  end

  ###### Methods concerning permissions ######

  def can_create?(model)
    organization_membership = find_organization_membership(model.organization_id)
    return false if organization_membership.nil?
    case model
      when ApplicationForm
        return organization_membership.is_admin
      else
        raise ArgumentError.new('Wrong type passed - only ApplicationForms allowed')
    end
  end

  def can_view?(model)
    organization_membership = find_organization_membership(model.organization_id)
    case model
      when PetApplication
        pet_application = model
        return !organization_membership.nil? ?
          organization_membership.is_admin :
          self.id == pet_application.user_id
      when ApplicationForm
        application_form = model
        return (!organization_membership.nil? && organization_membership.is_admin)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications and ApplicationForms allowed')
    end
  end

  def can_edit?(model)
    organization_membership = find_organization_membership(model.organization_id)
    case model
      when PetApplication
        pet_application = model
        return !organization_membership.nil? ?
          organization_membership.is_admin :
          self.id == pet_application.user_id
      when Pet
        return (!organization_membership.nil? && organization_membership.is_admin)
      when ApplicationForm
        return (!organization_membership.nil? && organization_membership.is_admin)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications, Pets, and ApplicationForms allowed')
    end
  end

  def can_delete?(model)
    organization_membership = find_organization_membership(model.organization_id)
    case model
      when PetApplication
        pet_application = model
        return !organization_membership.nil? ?
          organization_membership.is_admin :
          self.id == pet_application.user_id
      when ApplicationForm
        return (!organization_membership.nil? && organization_membership.is_admin)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications and ApplicationForms allowed')
    end
  end

  def find_organization_membership(organization_id)
    return OrganizationMembership.find_by(organization_id: organization_id, user_id: self.id)
  end
end
