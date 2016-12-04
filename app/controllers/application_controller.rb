class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  rescue_from Exception, with: :rescue_exception_with_json

  private

  def rescue_exception_with_json(exception)
    raise unless request.format.json?
    status = ActionDispatch::ExceptionWrapper.status_code_for_exception(exception.class.name)
    render json: { error: exception.message }, status: status
  end

end
