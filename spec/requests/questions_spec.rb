require 'rails_helper'

RSpec.describe "Questions", type: :request do
  let!(:question) { create(:question) }

  describe 'GET /questions' do
    let!(:questions) { [question] + create_list(:question, 5) }
    before { get questions_path }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs a list of all questions title and answer' do
      questions.each do |question|
        expect(response.body).to include(question.title)
        expect(response.body).to include(question.answer)
      end
    end
  end

  describe 'GET /questions/1' do
    before { get question_path(question) }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs the question' do
      expect(response.body).to include(question.body)
    end
    it 'outputs the answer' do
      expect(response.body).to include(question.answer)
    end
  end

  describe 'GET /questions/new' do
    before { get new_question_path }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs a form that allows the user to create a question' do
      expect(response.body).to match /<form[^<]+action="#{questions_path}"/
    end
  end

  describe 'GET /questions/1/edit' do
    before { get edit_question_path(question) }
    it 'succeeds' do
      expect(response).to be_success
    end
    it 'outputs a form that allows the user to create a question' do
      expect(response.body).to match /<form[^<]+action="#{question_path(question)}"/
    end
  end

  describe 'POST /questions' do
    let(:params) do
      {
        question: build(:question).attributes.slice(*%w{title body answer})
      }.with_indifferent_access
    end
    let(:request) { -> { post questions_path, params: params } }

    context 'when parameters are correct' do
      it 'creates a new Question' do
        expect(request).to change(Question, :count).by(1)
      end

      it "redirects the user to the question's page and displays a success message" do
        request.call
        question = Question.last
        expect(response).to redirect_to(question_path(question))
        follow_redirect!
        expect(response.body).to include('Question was successfully created.')
      end
    end
    context 'when the request is missing the `question` parameter' do
      let(:params) { {} }
      it 'raises an error' do
        expect(request).to raise_error(ActionController::ParameterMissing)
      end
    end
    context 'when parameters are incorrect' do
      before { params[:question][:body] = '' }
      it 'shows the form again, and displays an error' do
        request.call
        expect(response).to be_success
        expect(response.body).to include('1 error prohibited this question from being saved:')
      end
    end
  end

  describe 'PUT /questions/1' do
    let(:params) do
      {
        question: { body: 'Edited question' }
      }
    end
    let(:request) { -> { put question_path(question), params: params } }

    context 'when parameters are correct' do
      it 'updates the Question' do
        expect(request).to change {
          question.reload.body
        }.to(params[:question][:body])
      end

      it "redirects the user to the question's page and displays a success message" do
        request.call
        expect(response).to redirect_to(question_path(question))
        follow_redirect!
        expect(response.body).to include('Question was successfully updated.')
      end
    end
    context 'when the request is missing the `question` parameter' do
      let(:params) { {} }
      it 'raises an error' do
        expect(request).to raise_error(ActionController::ParameterMissing)
      end
    end
    context 'when parameters are incorrect' do
      before { params[:question][:body] = '' }
      it 'shows the form again, and displays an error' do
        request.call
        expect(response).to be_success
        expect(response.body).to include('1 error prohibited this question from being saved:')
      end
    end
  end

  describe 'DELETE /questions/1' do
    let(:request) { -> { delete question_path(question) } }
    it 'destroys the question' do
      expect(request).to change(Question, :count).by(-1)
    end
    it 'redirects the user to the list of questions and displays a success message' do
      request.call
      expect(response).to redirect_to(questions_path)
      follow_redirect!
      expect(response.body).to include('Question was successfully destroyed.')
    end
    context 'when the passed id does not exist' do
      let(:id) do
        ActiveRecord::Base.connection.execute(
          'SELECT last_value FROM questions_id_seq'
        ).first['last_value'] + 1
      end
      it 'raises a not found error' do
        expect {
          delete question_path(id: id)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
