class ApplicationFormSerializer < ActiveModel::Serializer
  attributes(*ApplicationForm.attribute_names.map(&:to_sym))

  has_many :questions
end
