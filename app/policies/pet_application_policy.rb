class PetApplicationPolicy < ApplicationPolicy
  attr_reader :user, :pet_application

  def initialize(user, pet_application)
    @user = user
    @pet_application = pet_application
  end

  def show?
    return user.can_view?(pet_application)
  end

  def update?
    return user.can_edit?(pet_application)
  end

  def destroy?
    return user.can_delete?(pet_application)
  end
end
