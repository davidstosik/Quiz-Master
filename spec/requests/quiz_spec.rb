require 'rails_helper'

RSpec.describe "Quiz", type: :request do
  let!(:question) { create(:question, answer: 'very unique string') }
  let!(:questions) { [question] + create_list(:question, 5) }

  describe 'GET /quiz' do
    before { get quiz_index_path }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs a list of all questions' do
      questions.each do |question|
        expect(response.body).to include(question.body)
      end
    end
  end

  describe 'GET /quiz/1' do
    before { get quiz_path(question) }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs the question' do
      expect(response.body).to include(question.body)
    end
    it 'does not output the answer' do
      expect(response.body).not_to include(question.answer)
    end
    it 'outputs a form that allows the user to answer' do
      path = Regexp.escape(answer_quiz_path(question))
      expect(response.body).to match(/<form [^>]*action=\"#{path}\"/)
    end
  end

  describe 'GET /quiz/1/answer' do
    context 'when no answer is supplied' do
      it 'fails with a 400 error' do
        expect {
          get answer_quiz_path(question)
        }.to raise_error(ActionController::ParameterMissing)
      end
    end
    context 'when an answer is supplied' do
      before { get answer_quiz_path(question), params: { answer: answer } }
      context 'and is empty' do
        let(:answer) { '' }
        it 'redirects the user to the quiz, and asks to supply an answer' do
          expect(response).to redirect_to(quiz_path(question))
          follow_redirect!
          expect(response.body).to include('You need to submit an answer.')
        end
      end
      context 'and is incorrect' do
        let(:answer) { 'incorrect' }
        it 'redirects the user to the quiz, and tells answer was incorrect' do
          expect(response).to redirect_to(quiz_path(question))
          follow_redirect!
          expect(response.body).to include('Your answer is incorrect!')
        end
      end
      context 'and is correct' do
        let(:answer) { question.answer }
        it 'succeeds' do
          expect(response).to be_success
        end
        it 'tells the user their answer was correct' do
          expect(response.body).to include('Correct')
        end
      end
    end
  end
end
