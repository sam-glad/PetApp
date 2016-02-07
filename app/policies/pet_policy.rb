class PetPolicy < ApplicationPolicy
  attr_reader :user, :pet

  def initialize(user, pet)
    @user = user
    @pet = pet
  end

  def update?
    return user.can_update?(pet)
  end
end
