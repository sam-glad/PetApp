class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :applicationFormId, :body, :inputType, :isRequired, :position

  def applicationFormId
    return object.application_form_id
  end

  def inputType
    return object.input_type
  end

  def isRequired
    return object.is_required
  end

  has_many :answers
end
