class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, allow_blank: false,
    length: { minimum: 2, maximum: 80 }
  validates :city, presence: true
  validates :state_province, presence: true
  validates :country, presence: true
  validates :website, allow_blank: true, allow_nil: true, uniqueness: true
  validates :email_address, allow_blank: true, allow_nil: true, uniqueness: true

  has_many :organization_memberships
  has_many :users, :through => :organization_memberships
  has_many :pets
  has_many :application_forms
  has_many :pet_applications
end
