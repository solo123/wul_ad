class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	# before_filter :authenticate_employee!
  before_filter :authenticate_or_token

  private
  def authenticate_or_token
    if params[:api_key] == "secret"
      @current_user = Employee.first
      return @current_user
    end
    authenticate_employee!
  end
end
