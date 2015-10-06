require 'rails_helper'

RSpec.describe Breed, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { should belong_to(:pet) }
  end
end
