class ApplicationForm < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, allow_blank: false

  belongs_to :organization
  has_many :questions
end
