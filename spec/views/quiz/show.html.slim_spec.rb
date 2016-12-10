require 'rails_helper'

RSpec.describe 'quiz/show', type: :view do
  let!(:question) { create(:question) }
  before { @question = question }

  it 'renders the question' do
    render
    expect(rendered).to include(question.body)
  end

  it 'does not render answer' do
    render
    expect(rendered).not_to include(question.answer)
  end

  it 'renders a form to answer' do
    render
    assert_select 'form[action=?][method=?]', answer_quiz_path(question), 'get' do
      assert_select 'input#answer[name=?]', 'answer'
      assert_select 'input[type=submit]'
    end
  end
end
