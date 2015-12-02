require 'rails_helper'

RSpec.describe Question, :type => :model do
  context 'Validations' do
    it { should validate_presence_of(:body) }
    it { should_not allow_value(' ').for(:body) }
    it { should have_many(:answers) }
    it { should validate_numericality_of(:position).is_greater_than(0) }
  end

  context 'Associations' do
    it { should belong_to(:application_form) }
    it { should belong_to(:pet_application) }
    it { should have_many(:answers).dependent(:destroy) }
  end

  context 'default scope' do
    let!(:question_one) { Question.create(body: 'Foo?', position: 2) }
    let!(:question_two) { Question.create(body: 'Bar?', position: 1) }

    it 'orders by ascending position' do
      Question.all.should eq [question_two, question_one]
    end
  end
end
