class PetSerializer < ActiveModel::Serializer
  attributes :id, :animal, :is_mix?, :age, :name, :size, :sex, :description,
  :status, :good_with_dogs, :good_with_cats, :good_with_kids, :organization_id
end
