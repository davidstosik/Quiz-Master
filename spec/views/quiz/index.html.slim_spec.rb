require 'rails_helper'

RSpec.describe "quiz/index", type: :view do
  before(:each) do
    assign(:questions, [
      Question.create!(
        :body => "MyText",
        :answer => "Answer"
      ),
      Question.create!(
        :body => "MyText",
        :answer => "Answer"
      )
    ])
  end

  it "renders a list of questions" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end

  it "does not render answers" do
    render
    assert_select "tr>td", :text => "Answer".to_s, :count => 0
  end
end
