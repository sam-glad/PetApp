class QuestionSerializer < ActiveModel::Serializer
  attributes(*Question.attribute_names.map(&:to_sym))

  has_many :answers
end
