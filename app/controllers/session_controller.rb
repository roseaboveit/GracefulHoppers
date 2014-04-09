class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.from_omniauth(auth_hash)
    session[:user_id] = user.id

    if user.email == 'example@example.com'
      redirect_to edit_user_path(user.id), notice: "Twitter Authenticated! Please fill out your profile."
    else
      redirect_to root_path, notice: "Signed In!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed Out!"
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end
