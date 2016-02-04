class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :organizationMemberships

  def organizationMemberships
    organization_memberships = OrganizationMembership.where(user_id: id)
    return ActiveModel::ArraySerializer.new(organization_memberships,
      serializer: OrganizationMembershipSerializer).as_json
  end

  has_many :organizations
end
