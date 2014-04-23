class UsersController < ApplicationController
  before_action :check_for_admin, only: [:admin, :index]

  def show
    @user = User.find(params[:id])
    if @user.unit == 0
      @user.unit = 1
      @user.save
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    check_email
    if current_user && @user == current_user
      render :edit
    else
      redirect_to root_path, notice: "You can't edit other users."
    end
  end

  def update
    @user = User.find(params[:id])
    check_initial_admin
    check_email
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

  def admin
  end

  def adminify
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    redirect_to users_path
  end

  private

  

  def user_params
    params.require(:user).permit(:name, :username, :twitter_uid, :email, :unit, :description, :admin)
  end

  def check_email
    @placeholder = @user.email == 'example@example.com' ? nil : @user.email
  end

  def check_initial_admin
    if @user.username == "roseaboveit"
        @user.admin = true
    end
  end
end
