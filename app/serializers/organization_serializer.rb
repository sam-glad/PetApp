class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :users
  has_many :pets
end
