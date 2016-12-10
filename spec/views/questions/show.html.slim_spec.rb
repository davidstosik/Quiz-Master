require 'rails_helper'

RSpec.describe 'questions/show', type: :view do
  let(:question) { create(:question) }
  before(:each) { assign(:question, question) }

  it 'renders attributes' do
    render
    expect(rendered).to include(question.body)
    expect(rendered).to include(question.answer)
  end
end
