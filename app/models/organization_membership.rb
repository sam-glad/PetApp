class OrganizationMembership < ActiveRecord::Base
  validates :user_id, presence: true
  validates :organization_id, presence: true

  belongs_to :user
  belongs_to :organization
end
