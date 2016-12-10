require 'rails_helper'

RSpec.describe 'questions/index', type: :view do
  let(:questions) { create_list(:question, 2) }
  before(:each) { assign(:questions, questions) }

  it 'renders a table of question objects' do
    render
    assert_select 'table tr' do |elements|
      elements[1..-1].each_with_index do |element, i|
        assert_select element, 'td', text: questions[i].title, count: 1
        assert_select element, 'td', text: questions[i].body, count: 0
        assert_select element, 'td', text: questions[i].answer, count: 1
      end
    end
  end
end
