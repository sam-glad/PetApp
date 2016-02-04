require 'rails_helper'

describe OrganizationMembership do
  context 'Validations' do
    describe 'name' do
       it { should validate_presence_of(:user_id) }
       it { should validate_presence_of(:organization_id) }
       it { should have_db_index([:user_id, :organization_id]) }
    end
  end

  context 'Associations' do
    it { should belong_to(:organization) }
    it { should belong_to(:user) }
  end
end
