class Pet < ActiveRecord::Base
  validates :name, presence: true, allow_blank: false,
    length: { minimum: 1, maximum: 80 }
  validates :age, presence: true
  validates :animal, presence: true
  validates :size, presence: true

  belongs_to :organization
end
