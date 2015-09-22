require 'rails_helper'

RSpec.describe Question, :type => :model do
  context 'Validations' do
    # Create with FactoryGirl to avoid known Shoulda-Matchers issue:
    # https://github.com/thoughtbot/shoulda-matchers/issues/336
    it "validates uniqueness of body" do
      FactoryGirl.create(:question)
        should validate_uniqueness_of(:body)
    end
    it { should validate_presence_of(:body) }
    it { should_not allow_value(' ').for(:body) }
    it { should validate_presence_of(:application_form) }
    it { should have_many(:answers) }
  end

  context 'Associations' do
    it { should belong_to(:application_form) }
  end
end
