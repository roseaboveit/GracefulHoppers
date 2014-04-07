class SessionController < ApplicationController
  def new
    @user = User.new
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by(twitter_uid: auth["uid"]) || User.new(auth)

    if user
      session[:user_id] = user.id
    else
      if user.save
        session[:user_id] = user.id
      else
        flash[:error] = "There was a problem! :("
      end
    end

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
