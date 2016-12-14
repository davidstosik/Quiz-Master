require 'rails_helper'

RSpec.describe 'quiz/index.json.jbuilder', type: :view do
  let(:json_result) { JSON.parse(rendered) }
  let(:questions) { create_list(:question, 2) }
  before(:each) do
    assign(:questions, questions)
    render
  end

  it 'renders a JSON list of the right size' do
    expect(json_result.count).to eq 2
  end

  it 'renders attributes of the passed questions' do
    json_result.each_with_index do |item, i|
      %w(id title body).each do |attr|
        expect(item[attr]).to eq questions[i].send(attr)
      end
      %w(created_at updated_at).each do |attr|
        expected = questions[i].send(attr).to_i
        date = DateTime.parse(item[attr]).to_i
        expect(date).to eq expected
      end
    end
  end

  it "adds each question's URL" do
    json_result.each_with_index do |item, i|
      expect(item['url']).to eq quiz_url(questions[i], format: :json)
    end
  end

  it 'does not render answers' do
    json_result.each do |item|
      expect(item['answer']).not_to be_present
    end
  end
end
