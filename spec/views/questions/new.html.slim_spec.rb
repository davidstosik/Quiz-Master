require 'rails_helper'

RSpec.describe 'questions/new', type: :view do
  let(:question) { build(:question) }
  before(:each) { assign(:question, question) }

  it 'renders new question form' do
    render
    assert_select 'form[action=?][method=?]', questions_path, 'post' do
      assert_select 'textarea#question_body[name=?]', 'question[body]'
      assert_select 'input#question_answer[name=?]', 'question[answer]'
    end
  end
end
