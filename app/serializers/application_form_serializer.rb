class ApplicationFormSerializer < ActiveModel::Serializer
  attributes :id, :name, :organization_id

  has_many :questions
  has_many :pets
end
