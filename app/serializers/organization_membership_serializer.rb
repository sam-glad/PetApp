class OrganizationMembershipSerializer < ActiveModel::Serializer
  attributes :id, :organizationId, :userId, :isAdmin

  def organizationId
    return object.organization_id
  end

  def userId
    return object.user_id
  end

  def isAdmin
    return object.is_admin
  end
end
