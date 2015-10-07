class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :input_type, :is_required

  has_many :answers
end
