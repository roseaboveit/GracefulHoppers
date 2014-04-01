class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      redirect_to new_user_path, notice: "Please use only valid inputs."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :twitter_uid, :email, :unit, :description, :admin)
  end

end
