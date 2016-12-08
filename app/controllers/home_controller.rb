class HomeController < ApplicationController
  def index
    @cards = {
      crud: questions_path,
      quiz: quiz_index_path,
      random: random_quiz_index_path
    }
  end
end
