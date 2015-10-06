class Breed < ActiveRecord::Base
  validates :name, presence: true

  belongs_to :pet
end
