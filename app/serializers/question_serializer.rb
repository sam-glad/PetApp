class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :body, :input_type, :is_required, :position

  has_many :answers
end
