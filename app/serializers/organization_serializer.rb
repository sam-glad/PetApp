class OrganizationSerializer < ActiveModel::Serializer
  attributes(*Organization.attribute_names.map(&:to_sym))

  has_many :users
end
