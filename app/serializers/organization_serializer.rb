class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name, :city, :stateProvince, :country, :phoneNumber,
    :phoneExtension, :emailAddress, :website, :phonePreferred

  def stateProvince
    return object.state_province
  end

  def phoneNumber
    return object.phone_number
  end

  def phoneExtension
    return object.phone_extension
  end

  def emailAddress
    return object.email_address
  end

  def phonePreferred
    return object.phone_preferred
  end

  has_many :users
end
