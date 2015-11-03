require 'rails_helper'

RSpec.describe ApplicationForm, :type => :model do
  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should_not allow_value(' ').for(:name) }
    it { should allow_value(:nil).for(:organization_id) }
  end

  context 'Associations' do
    it { should belong_to(:organization) }
    it { should have_many(:questions).dependent(:destroy) }
    it { should accept_nested_attributes_for(:questions) }
  end
end
