class OrganizationMembershipSerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :user_id, :can_manage_pet_applications,
    :can_edit_all_pets, :can_manage_application_forms
end
