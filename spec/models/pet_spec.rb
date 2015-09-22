require 'rails_helper'

RSpec.describe Pet, :type => :model do
  context 'Validations' do
     it { should validate_presence_of(:name) }
     it { should validate_length_of(:name).is_at_least(1).is_at_most(80) }
     it { should_not allow_value('', nil).for(:name) }
     it { should validate_presence_of(:age) }
     it { should validate_presence_of(:animal) }
     it { should validate_presence_of(:size) }
  end

  context 'Associations' do
    it { should belong_to(:organization) }
  end
end
