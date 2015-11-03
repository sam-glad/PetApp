class PetApplicationSerializer < ActiveModel::Serializer
  attributes :id, :pet_id

  has_many :questions
  has_one :organization
end
