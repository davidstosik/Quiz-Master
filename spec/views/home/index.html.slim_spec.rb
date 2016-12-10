require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  let(:cards) { {
    crud: questions_path,
    quiz: quiz_index_path,
    random: random_quiz_index_path
  } }
  before(:each) do
    assign(:cards, cards)
  end

  it 'renders the cards' do
    render
    cards.each do |key, _|
      assert_select ".card#card-#{key}", count: 1
    end
  end

  it 'renders links in the cards' do
    render
    cards.each do |key, link|
      next unless link
      assert_select ".card#card-#{key} a[href=?]", link, count: 2
    end
  end
end
