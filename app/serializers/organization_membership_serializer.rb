class OrganizationMembershipSerializer < ActiveModel::Serializer
  attributes :id, :organization_id, :user_id, :is_admin
end
