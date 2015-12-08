class PetApplicationSerializer < ActiveModel::Serializer
  attributes :id, :petId, :status, :createdAt, :applicationType, :organizationId,
    :userId

  def petId
    return object.pet_id
  end

  def createdAt
    return object.created_at
  end

  def applicationType
    return object.application_type
  end

  def organizationId
    return object.organization_id
  end

  def userId
    return object.user_id
  end

  has_many :questions
  has_one :organization
  has_one :user
  has_one :pet
end
