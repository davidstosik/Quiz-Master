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

  describe '.random' do
    subject { described_class.random }
    context 'when there are questions in the database' do
      before { create_list(:question, 3) }
      it 'returns a Question' do
        is_expected.to be_a(Question)
      end
      it 'returns an existing Question' do
        expect(Question.find(subject.id)).to be_present
      end
    end
    context 'when the database is empty' do
      it 'returns nil' do
        is_expected.to be_nil
      end
    end
  end

  describe '#answer_is_correct?' do
    subject { question.answer_is_correct?(answer) }
    context 'when answer is correct' do
      let(:answer) { question.answer }
      it { is_expected.to be_truthy }
    end
    context 'when answer is not correct' do
      let(:answer) { 'incorrect' }
      it { is_expected.to be_falsy }
    end
    context 'when the answer is correct with a different letter case' do
      let(:question) { build(:question, answer: 'lower case') }
      let(:answer) { 'Lower Case' }
      it { is_expected.to be_truthy }
    end
    context 'when the answer is correct with trailing spaces' do
      let(:question) { build(:question, answer: 'lower case') }
      let(:answer) { ' lower case ' }
      it { is_expected.to be_truthy }
    end
    context 'when the correct answer is numeric' do
      let(:question) { build(:question, answer: '5') }
      context 'and passed answer is the same number' do
        let(:answer) { '5' }
        it { is_expected.to be_truthy }
      end
      context 'and passed answer is the corresponding number in words' do
        let(:answer) { 'five' }
        it { is_expected.to be_truthy }
      end
    end
    context 'when the correct answer contains numbers' do
      let(:question) { build(:question, answer: '5 apples, 2 oranges') }
      context 'and passed answer is the same' do
        let(:answer) { question.answer }
        it { is_expected.to be_truthy }
      end
      context 'and passed answer matches, with all numbers into words' do
        let(:answer) { 'five apples, two oranges' }
        it { is_expected.to be_truthy }
      end
      context 'and passed answer matches, with some numbers into words' do
        let(:answer) { 'five apples, 2 oranges' }
        it { is_expected.to be_truthy }
      end
      context 'and passed answer does not match' do
        let(:answer) { 'five apples, three oranges' }
        it { is_expected.to be_falsy }
      end
    end
  end
end
