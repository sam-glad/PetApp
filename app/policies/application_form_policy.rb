class ApplicationFormPolicy < ApplicationPolicy
  attr_reader :user, :application_form

  def initialize(user, application_form)
    @user = user
    @application_form = application_form
  end

  def create?
    return user.can_create?(application_form)
  end

  def index?
    return user.can_view?(application_form.first)
  end

  def show?
    return user.can_view?(application_form)
  end

  def update?
    return user.can_update?(application_form)
  end

  def destroy?
    return user.can_delete?(application_form)
  end
end
