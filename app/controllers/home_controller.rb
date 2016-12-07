class HomeController < ApplicationController
  def index
    @cards = {
      crud: questions_path,
      quiz: quiz_index_path,
      random: nil
    }
  end
end
