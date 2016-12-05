require 'rails_helper'

RSpec.describe "quiz/answer", type: :view do
  before(:each) do
    @question = assign(:question, Question.create!(
      :body => "MyText",
      :answer => "Unique Answer"
    ))
  end

  it "displays 'Correct'" do
    render
    expect(rendered).to match(/Correct/)
  end
end
