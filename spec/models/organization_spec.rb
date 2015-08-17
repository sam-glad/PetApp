require 'rails_helper'

describe Organization do
  context 'Validations' do
    describe 'name' do
       it { should validate_presence_of(:name) }
       it { should ensure_length_of(:name).is_at_least(2).is_at_most(80) }
    end
  end

  context 'Associations' do
    it { should have_many(:organization_memberships) }
    it { should have_many(:users).through(:organization_memberships) }
  end
end
