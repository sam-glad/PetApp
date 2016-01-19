class ApplicationForm < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { scope: :organization_id }, allow_blank: false

  belongs_to :organization
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
end
