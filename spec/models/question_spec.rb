require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { build(:question) }
  describe 'attributes' do
    it 'should have a body' do
      expect(question.body).to be_present
    end
    it 'should have an answer' do
      expect(question.answer).to be_present
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:answer) }
  end
end
