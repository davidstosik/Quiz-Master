require 'rails_helper'

RSpec.describe 'quiz/answer', type: :view do
  let!(:question) { create(:question) }
  before { assign(:question, question) }

  it "displays 'Correct'" do
    render
    expect(rendered).to include('Correct!')
  end
end
