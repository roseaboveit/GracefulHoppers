class UsersController < ApplicationController
  before_action :check_for_admin, only: [:admin, :index]

  def show
    @user = User.find(params[:id])
    @units = Unit.where("id <= ?", @user.unit)
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

  def complete_lesson
    @completed_lesson = CompletedLesson.new
    @completed_lesson.user_id = current_user.id
    @completed_lesson.lesson_id = params[:id]
    @completed_lesson.save
    redirect_to user_path(current_user)
  end

  private

  def completed_lesson_params
    params.require(:completed_lesson).permit(:user_id, :lesson_id)  
  end  

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
