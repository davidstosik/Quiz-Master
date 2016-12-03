require 'rails_helper'
RSpec.describe QuizController, type: :controller do
  let!(:question) { create(:question) }
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all questions as @questions' do
      get :index, params: {}, session: valid_session
      expect(assigns(:questions)).to eq([question])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested question as @question' do
      get :show, params: {id: question.to_param}, session: valid_session
      expect(assigns(:question)).to eq(question)
    end
  end

  describe 'GET #answer' do
    let(:user_answer) { 'my answer' }
    before do
      params = {
        id: question.to_param,
        answer: user_answer
      }
      get :answer, params: params, session: valid_session
    end

    it 'assigns the requested question as @question' do
      expect(assigns(:question)).to eq(question)
    end

    it "assigns the user's answer as @user_answer" do
      expect(assigns(:user_answer)).to eq(user_answer)
    end

    context 'when the answer is wrong' do
      let(:user_answer) { 'incorrect' }
      it 'redirects the user to the quiz page' do
        expect(response).to redirect_to(quiz_path(question))
      end
    end

    context 'when the answer is correct' do
      let(:user_answer) { question.answer }
      it 'renders the "answer" view' do
        expect(response).to render_template(:answer)
      end
    end
  end
end
