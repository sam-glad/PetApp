class PetSerializer < ActiveModel::Serializer
  attributes :id, :animal, :is_mix?, :age, :name, :size, :sex, :description,
  :status, :good_with_dogs, :good_with_cats, :good_with_kids, :organization_id,
  :adoption_application_id, :foster_application_id, :is_adoptable, :is_fosterable

  has_many :breeds
  has_one :organization
end
