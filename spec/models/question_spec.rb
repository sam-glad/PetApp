require 'rails_helper'

RSpec.describe Question, :type => :model do
  context 'Validations' do
    it { should validate_presence_of(:body) }
    it { should_not allow_value(' ').for(:body) }
    it { should validate_presence_of(:application_form) }
    it { should have_many(:answers) }
  end

  context 'Associations' do
    it { should belong_to(:application_form) }
    it { should have_many(:answers).dependent(:destroy) }
  end
end
