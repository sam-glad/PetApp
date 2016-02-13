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
    organization_membership = find_organization_membership(model)
    case model
      when ApplicationForm
        return has_application_form_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only ApplicationForms allowed')
    end
  end

  def can_view?(model)
    organization_membership = find_organization_membership(model)
    case model
      when PetApplication
        pet_application = model
        return has_pet_application_privileges(organization_membership, pet_application)
      when ApplicationForm
        application_form = model
        return has_application_form_privileges(organization_membership)
      when OrganizationMembership
        return has_organization_membership_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications, ApplicationForms, and OrganizationMemberships allowed')
    end
  end

  def can_update?(model)
    organization_membership = find_organization_membership(model)
    case model
      when PetApplication
        pet_application = model
        return has_pet_application_privileges(organization_membership, pet_application)
      when Pet
        return has_application_form_privileges(organization_membership)
      when ApplicationForm
        return has_application_form_privileges(organization_membership)
      when OrganizationMembership
        return has_organization_membership_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications, Pets, ApplicationForms, and OrganizationMemberships allowed')
    end
  end

  def can_delete?(model)
    organization_membership = find_organization_membership(model)
    case model
      when PetApplication
        pet_application = model
        return has_pet_application_privileges(organization_membership, pet_application)
      when ApplicationForm
        return has_application_form_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications and ApplicationForms allowed')
    end
  end

  def find_organization_membership(model)
    return model.class.column_names.include?('organization_id') ?
      OrganizationMembership.find_by(organization_id: model.organization_id, user_id: self.id) : nil
  end

  def has_pet_application_privileges(organization_membership, pet_application)
    return organization_membership.nil? ?
      self.id == pet_application.user_id : organization_membership.is_admin
  end

  def has_application_form_privileges(organization_membership)
    (!organization_membership.nil? && organization_membership.is_admin)
  end

  def has_organization_membership_privileges(organization_membership)
    (!organization_membership.nil? && organization_membership.is_admin)
  end
end
