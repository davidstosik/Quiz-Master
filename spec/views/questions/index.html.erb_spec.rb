require 'rails_helper'

RSpec.describe "questions/index", type: :view do
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
    assert_select "tr>td", :text => "Answer".to_s, :count => 2
  end
end
