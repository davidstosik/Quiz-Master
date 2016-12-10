require 'rails_helper'

RSpec.describe 'questions/show.json.jbuilder', type: :view do
  let(:question) { create(:question) }
  let(:json_result) { JSON.parse(rendered) }
  before(:each) do
    assign(:question, question)
    render
  end

  it "renders JSON with all the question's attributes" do
    %w(id title body answer).each do |attr|
      expect(json_result[attr]).to eq question.send(attr)
    end
    %w(created_at updated_at).each do |attr|
      expected = question.send(attr).to_i
      date = DateTime.parse(json_result[attr]).to_i
      expect(date).to eq expected
    end
  end

  it "adds the question's URL" do
    expect(json_result['url']).to eq question_url(question, format: :json)
  end
end
