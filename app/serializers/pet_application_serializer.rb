class PetApplicationSerializer < ActiveModel::Serializer
  attributes :id, :pet_id, :status, :created_at

  has_many :questions
  has_one :organization
  has_one :user
  has_one :pet
end
