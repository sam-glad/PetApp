require 'rails_helper'

RSpec.describe Answer, :type => :model do
  context 'Validations' do
    it { should validate_presence_of(:body) }
  end

  context 'Associations' do
    it { should belong_to(:question) }
  end
end
