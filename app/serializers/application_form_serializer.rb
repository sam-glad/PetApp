class ApplicationFormSerializer < ActiveModel::Serializer
  attributes :id, :name, :organizationId

  def organizationId
    return object.organization_id;
  end

  has_many :questions
end
