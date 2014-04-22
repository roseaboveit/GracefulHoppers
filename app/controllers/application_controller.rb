class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  helper_method :current_user

  def check_for_admin
    if current_user.nil?
      redirect_to root_path, notice: "You are not authorized to view this page"
    else
      unless current_user.admin?
        redirect_to root_path, notice: "You are not authorized to view this page"
      end
    end
  end
end
