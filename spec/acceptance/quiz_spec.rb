require 'support/rspec_api_documentation'

RSpec.resource 'Quiz' do
  let(:response_json) { JSON.parse(response_body) }
  let!(:question) { create(:question) }

  get '/quiz.json' do
    example_request 'List all Questions for a quiz' do
      explanation 'Returns all Question records, no answers.'
      expect(status).to eq 200
      expect(response_json.count).to eq 1
      expect(response_json.first['body']).to eq question.body
      expect(response_json.first).not_to have_key('answer')
    end
  end

  get '/quiz/:id.json' do
    parameter :id, "The question's id", required: true
    let(:id) { question.id }

    example_request 'Retrieve a Question for a quiz' do
      explanation 'Returns one Question by id, no answer.'
      expect(status).to eq 200
      expect(response_json['body']).to eq question.body
      expect(response_json).not_to have_key('answer')
    end

    example 'When question is not found', document: false do
      do_request(id: 0)
      expect(status).to eq 404
    end
  end

  get 'quiz/random.json' do
    example 'Retrieve a random Question for a quiz' do
      explanation 'Returns a random Question, no answer.'
      expect(Question).to receive(:random) { question }
      do_request
      expect(status).to eq 200
      expect(response_json['body']).to eq question.body
      expect(response_json).not_to have_key('answer')
    end
  end

  get '/quiz/:id/answer.json' do
    parameter :id, "The question's id", required: true
    let(:id) { question.id }

    parameter :answer, 'The user-submitted answer', required: true
    let(:answer) { 'incorrect answer' }

    example_request 'Check answer to a question' do
      explanation 'Will check the user-submitted answer and reply whether it is correct or not.'
      expect(status).to eq 200
      expect(response_json['correct']).to eq false
    end

    example 'When the answer is correct', document: false do
      do_request(answer: question.answer)
      expect(status).to eq 200
      expect(response_json['correct']).to eq true
    end

    example 'When no answer was passed', document: false do
      do_request(answer: nil)
      expect(status).to eq 400
    end
  end
end
