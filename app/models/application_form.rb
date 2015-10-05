class ApplicationForm < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, allow_blank: false

  belongs_to :organization
  has_many :questions, inverse_of: :application_form, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
  has_many :pets
end
