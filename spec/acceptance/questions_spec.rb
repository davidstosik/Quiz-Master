require 'support/rspec_api_documentation'

RSpec.resource 'Questions' do
  let(:response_json) { JSON.parse(response_body) }
  let(:question) { create(:question) }
  let!(:questions) { [question] + create_list(:question, 4) }

  get '/questions.json' do
    example_request 'List all Questions' do
      explanation 'Returns all Question records, including all their attributes (even the answer).'
      expect(status).to eq 200
      expect(response_json.count).to eq 5
      expect(response_json.map { |q| q['body'] }).to match_array(questions.map(&:body))
    end
  end

  get '/questions/:id.json' do
    parameter :id, "The question's id", required: true
    let(:id) { question.id }

    example_request 'Retrieve a full Question' do
      explanation 'Returns one Question by id, including all its attributes (even the answer).'
      expect(status).to eq 200
      %w(id body answer).each do |attribute|
        expect(response_json[attribute]).to eq question.send(attribute)
      end
    end

    example 'When question is not found', document: false do
      do_request(id: 0)
      expect(status).to eq 404
    end
  end

  post '/questions.json' do
    let(:question) { build(:question) }
    parameter :title, 'A plain text title', scope: :question, required: true
    let(:title) { question.title }

    parameter :body, 'The question', scope: :question, required: true
    let(:body) { question.body }

    parameter :answer, 'Its answer', scope: :question, required: true
    let(:answer) { question.answer }

    example 'Create a new Question' do
      explanation 'Creates a new Question record.'
      expect { do_request }.to change(Question, :count).by(1)
      expect(status).to eq 201
      %w(body answer).each do |attribute|
        expect(response_json[attribute]).to eq send(attribute)
      end
      expect(response_json['id']).not_to be_nil
    end

    example 'When parameters are invalid', document: false do
      do_request(question: { body: '' })
      expect(status).to eq 422
    end
  end

  patch '/questions/:id.json' do
    parameter :id, "The question's id", required: true
    let(:id) { question.id }

    parameter :body, 'The question', scope: :question
    let(:body) { 'New body' }

    parameter :answer, 'Its answer', scope: :question
    let(:answer) { 'new answer' }

    example_request 'Update a Question' do
      explanation 'Updates an existing Question.'
      expect(status).to eq 200
      question.reload
      %w(body answer).each do |attribute|
        expect(response_json[attribute]).to eq send(attribute)
        expect(response_json[attribute]).to eq question.reload.send(attribute)
      end
    end
  end

  delete '/questions/:id.json' do
    parameter :id, "The question's id", required: true
    let(:id) { question.id }

    example_request 'Delete a Question' do
      explanation 'Deletes an existing Question, by id.'
      expect(status).to eq 204
      expect(Question.count).to eq 4
      expect(Question.find_by_id(id)).to be_nil
    end
  end
end
