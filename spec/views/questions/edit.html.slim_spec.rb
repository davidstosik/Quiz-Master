require 'rails_helper'

RSpec.describe 'questions/edit', type: :view do
  let(:question) { create(:question) }
  before(:each) { assign(:question, question) }

  it 'renders the edit question form' do
    render

    assert_select 'form[action=?][method=?]', question_path(question), 'post' do
      assert_select 'textarea#question_body[name=?]', 'question[body]'
      assert_select 'input#question_answer[name=?]', 'question[answer]'
    end
  end
end
