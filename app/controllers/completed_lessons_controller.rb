class CompletedLessonsController < ApplicationController

  def create
    @completed_lesson = CompletedLesson.new
    @completed_lesson.user_id = current_user.id
    @completed_lesson.lesson_id = params[:lesson_id]
    @completed_lesson.save
    redirect_to user_path(current_user)
  end

  private

  def completed_lesson_params
    params.require(:completed_lesson).permit(:user_id, :lesson_id)  
  end 
end
