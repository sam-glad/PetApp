class OrganizationMembership < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: true
  validates :organization_id, presence: true, uniqueness: true

  belongs_to :user
  belongs_to :organization
end
