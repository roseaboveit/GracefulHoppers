class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
  
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
