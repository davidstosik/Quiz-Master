require 'rails_helper'

RSpec.describe 'quiz/index', type: :view do
  let(:questions) { create_list(:question, 2) }
  before(:each) { assign(:questions, questions) }

  it 'renders a table of question titles' do
    render
    assert_select 'table tr' do |elements|
      elements[1..-1].each_with_index do |element, i|
        assert_select element, 'td', text: questions[i].body, count: 1
        assert_select element, 'a[href=?]', quiz_path(questions[i])
      end
    end
  end

  it 'does not render answers' do
    render
    questions.each do |question|
      assert_select 'tr>td', text: question.answer, count: 0
    end
  end
end
