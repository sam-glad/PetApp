class PetSerializer < ActiveModel::Serializer
  attributes :id, :animal, :mix, :age, :name, :available_date, :size, :sex,
  :weight, :description, :status, :good_with_dogs, :good_with_cats,
  :good_with_kids, :fence_required, :fence_height, :breed_experience_required,
  :organization_id
end
