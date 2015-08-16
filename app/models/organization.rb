class Organization < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, allow_blank: false,
    length: { minimum: 2, maximum: 80 }

  has_many :organization_memberships
  has_many :users, :through => :organization_memberships
end
