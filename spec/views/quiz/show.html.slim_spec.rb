require 'rails_helper'

RSpec.describe "quiz/show", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :body => "MyText",
      :answer => "Unique Answer"
    ))
  end

  it "renders question in <p>" do
    render
    expect(rendered).to match(/MyText/)
  end

  it "does not render answer" do
    render
    expect(rendered).not_to match(/Unique Answer/)
  end

  it "renders a form to answer" do
    render
    assert_select "form[action=\"#{answer_quiz_path(@question)}\"]", count: 1
    assert_select "input[name=answer]", count: 1
    assert_select "input[type=submit]", count: 1
  end
end
