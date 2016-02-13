class OrganizationMembershipPolicy < ApplicationPolicy
  attr_reader :user, :organization_membership

  def initialize(user, organization_membership)
    @user = user
    @organization_membership = organization_membership
  end

  def index?
    return user.can_view?(organization_membership.first)
  end

  def show?
    return user.can_view?(organization_membership)
  end

  def update?
    return user.can_update?(organization_membership)
  end
end
