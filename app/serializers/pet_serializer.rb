class PetSerializer < ActiveModel::Serializer
  attributes :id, :animal, :is_mix?, :age, :name, :size, :sex, :description,
  :status, :goodWithDogs, :goodWithCats, :goodWithKids, :organizationId,
  :adoptionApplicationId, :fosterApplicationId, :isAdoptable, :isFosterable

  def goodWithDogs
    return object.good_with_dogs
  end

  def goodWithCats
    return object.good_with_cats
  end

  def goodWithKids
    return object.good_with_kids
  end

  def organizationId
    return object.organization_id
  end

  def adoptionApplicationId
    return object.adoption_application_id
  end

  def fosterApplicationId
    return object.foster_application_id
  end

  def isAdoptable
    return object.is_adoptable
  end

  def isFosterable
    return object.is_fosterable
  end

  has_many :breeds
  has_one :organization
end
