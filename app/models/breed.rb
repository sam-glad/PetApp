class Breed < ActiveRecord::Base
  validates :name, presence: true
  validates :pet_id, presence: true

  belongs_to :pet
end
