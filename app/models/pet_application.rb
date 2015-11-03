class PetApplication < ActiveRecord::Base
  validates :user, presence: true
  validates :pet, presence: true
  validates :organization, presence: true
  validates :status, presence: true
  validates :questions, presence: true

  # enum status: [ :pending, :approved, :denied ]
  # enum type: [ :adoption, :foster ]

  belongs_to :user
  belongs_to :pet
  belongs_to :organization
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true
end
