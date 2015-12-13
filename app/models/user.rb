class User < ActiveRecord::Base
  def can_view_all_pet_applications(organization_id)
    organization_membership = find_organization_membership(organization_id)
    return !organization_membership.nil? ? organization_membership.can_view_all_applications : false
  end

  def can_view(pet_application)
    organization_membership = find_organization_membership(pet_application.organization_id)
    return !organization_membership.nil? ?
      organization_membership.can_view_all_applications :
      self.id == pet_application.user_id
  end

  def can_edit(pet_application)
    organization_membership = find_organization_membership(pet_application.organization_id)
    return !organization_membership.nil? ?
      organization_membership.can_edit_all_applications :
      self.id == pet_application.user_id
  end

  def can_delete(pet_application)
    organization_membership = find_organization_membership(pet_application.organization_id)
    return !organization_membership.nil? ?
      organization_membership.can_delete_all_applications :
      self.id == pet_application.user_id
  end

  def find_organization_membership(organization_id)
    return OrganizationMembership.find_by(organization_id: organization_id, user_id: self.id)
  end

  has_many :organization_memberships
  has_many :organizations, :through => :organization_memberships

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  include DeviseTokenAuth::Concerns::User
end
