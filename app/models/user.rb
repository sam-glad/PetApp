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

  def admin_organization_ids
    admin_organization_membership_ids = OrganizationMembership.where(user_id: self.id, is_admin: true).pluck('organization_id')
    return admin_organization_membership_ids.present? ? admin_organization_membership_ids : []
  end

  def admin_organizations
    admin_organization_memberships = self.admin_organization_ids
    return Organization.where(id: admin_organization_memberships)
  end

  ###### Methods concerning permissions ######

  def can_create?(model)
    organization_membership = find_organization_membership(model)
    case model
      when ApplicationForm
        return self.has_application_form_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only ApplicationForms allowed')
    end
  end

  def can_view?(model)
    organization_membership = find_organization_membership(model)
    case model
      when PetApplication
        pet_application = model
        return self.has_pet_application_privileges(organization_membership, pet_application)
      when ApplicationForm
        application_form = model
        return self.has_application_form_privileges(organization_membership)
      when OrganizationMembership
        return self.has_organization_membership_privileges(organization_membership)
      when nil
        return true
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications, ApplicationForms, and OrganizationMemberships allowed')
    end
  end

  def can_update?(model)
    organization_membership = find_organization_membership(model)
    case model
      when PetApplication
        pet_application = model
        return self.has_pet_application_privileges(organization_membership, pet_application)
      when Pet
        return self.has_application_form_privileges(organization_membership)
      when ApplicationForm
        return self.has_application_form_privileges(organization_membership)
      when OrganizationMembership
        return self.has_organization_membership_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications, Pets, ApplicationForms, and OrganizationMemberships allowed')
    end
  end

  def can_delete?(model)
    organization_membership = find_organization_membership(model)
    case model
      when PetApplication
        pet_application = model
        return self.has_pet_application_privileges(organization_membership, pet_application)
      when ApplicationForm
        return self.has_application_form_privileges(organization_membership)
      else
        raise ArgumentError.new('Wrong type passed - only PetApplications and ApplicationForms allowed')
    end
  end

  def find_organization_membership(model)
    return (!model.nil? && model.class.column_names.include?('organization_id')) ?
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
