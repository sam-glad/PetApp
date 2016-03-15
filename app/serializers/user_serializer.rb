class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :organizationMemberships, :adminOrganizationIds,
    :adminOrganizations

  def organizationMemberships
    organization_memberships = OrganizationMembership.where(user_id: id)
    return ActiveModel::ArraySerializer.new(organization_memberships,
      serializer: OrganizationMembershipSerializer).as_json
  end

  def adminOrganizationIds
    return object.admin_organization_ids
  end

  def adminOrganizations
    return object.admin_organizations
  end

  has_many :organizations
end
