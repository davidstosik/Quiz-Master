class QuizController < ApplicationController
  before_action :set_question, only: [:show, :answer]
  before_action :set_user_answer, only: [:answer]

  # GET /quiz
  # GET /quiz.json
  def index
    @questions = Question.all
  end

  # GET /quiz/1
  # GET /quiz/1.json
  def show
  end

  # GET /quiz/1/answer
  # GET /quiz/1/answer.json
  def answer
    respond_to do |format|
      if @question.answer_is_correct?(@user_answer)
        format.html { render :answer }
        format.json { render json: { correct: true } }
      else
        format.html { redirect_to quiz_path(@question), alert: I18n.t('quiz.answer.incorrect') }
        format.json { render json: { correct: false } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_user_answer
      @user_answer = params.require(:answer)
    end
end
