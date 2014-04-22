class LessonsController < ApplicationController
  
  before_action :check_for_admin, only: [:new, :create, :edit, :update]

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new(lesson_params)
    if @lesson.save
      redirect_to edit_lesson_path(@lesson)
    else
      redirect_to new_lesson_path, notice: "Remember to fill out all the fields"
    end
  end

  def edit
    @lesson = Lesson.find(params[:id])
    @segments = Segment.where("lesson_id = ?", params[:id])
  end

  def update
    @lesson = Lesson.find(params[:id])
    @lesson.update(lesson_params)
    if @lesson.save
      redirect_to @lesson
    else
      redirect_to edit_lesson_path, notice: "Please use only valid values."
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    @segments = Segment.where("lesson_id = ?", params[:id]).sort_by { |k| k["place_value"] }
    if current_user && current_user.admin?
      render :show
    elsif current_user && @lesson.unit_published?
      if current_user.check_progress?(@lesson.unit_id)
        render :show
      else
        redirect_to unit_path(current_user.unit), notice: "Here's the unit you are currently on. Don't skip ahead."
      end
    elsif current_user && current_user.check_progress?(@lesson.unit_id)
      redirect_to user_path(current_user), notice: "This content is not yet available"
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  private

  def lesson_params
    params.require(:lesson).permit(:points, :unit_id, :path, :description, :title)
  end
end
