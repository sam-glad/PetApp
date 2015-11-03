class Pet < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false,
    length: { minimum: 1, maximum: 80 }
  validates :age, presence: true
  validates :animal, presence: true
  validates :size, presence: true
  validates :breeds, presence: true

  belongs_to :organization
  has_many :breeds
  has_many :pet_applications

  belongs_to :adoption_application, class_name: 'ApplicationForm', foreign_key: 'adoption_application_id'
  belongs_to :foster_application, class_name: 'ApplicationForm', foreign_key: 'foster_application_id'
end
