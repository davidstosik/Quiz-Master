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
      if @user_answer.empty?
        alert = I18n.t('quiz.answer.empty')
      elsif !@question.answer_is_correct?(@user_answer)
        alert = I18n.t('quiz.answer.incorrect')
      end

      if alert
        format.html { redirect_to quiz_path(@question), alert: alert }
        format.json { render json: { correct: false, message: alert } }
      else
        format.html { render :answer }
        format.json { render json: { correct: true } }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    def set_user_answer
      unless (@user_answer = params[:answer])
        # Allow empty string for a better error message to the user.
        raise ActionController::ParameterMissing.new(:answer)
      end
    end
end
