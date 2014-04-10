class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    check_email
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      unless @placeholder
        Notifier.introduction(@user).deliver
      end
      redirect_to @user
    else
      redirect_to edit_user_path(@user.id), notice: "Please use only valid inputs."
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "User #{@user.username} has been deleted"
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :twitter_uid, :email, :unit, :description, :admin)
  end

  def check_email
    if @user.email == 'example@example.com'
      @placeholder = nil
    else
      @placeholder = @user.email
    end
  end
end
