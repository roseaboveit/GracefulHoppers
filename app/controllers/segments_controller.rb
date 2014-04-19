class SegmentsController < ApplicationController

  before_action :check_for_admin, only: [:new, :create, :edit, :update, :destroy]

  def new
    @segment = Segment.new
  end

  def create
    @segment = Segment.new(segment_params)
    if @segment.save
      redirect_to edit_lesson_path(id: @segment.lesson_id.to_i)
    else
      redirect_to new_segment_path
    end
  end

  def edit
    @segment = Segment.find(params[:id])
  end

  def update
    @segment = Segment.find(params[:id])
    @segment.update(segment_params)
    if @segment.save
      redirect_to edit_lesson_path(id: @segment.lesson_id.to_i)
    else
      redirect_to edit_segment_path(@segment.id)
    end
  end

  def destroy
    @segment = Segment.find(params[:id])
    @lesson_id = @segment.lesson_id
    @segment.delete
    redirect_to edit_lesson_path(@lesson_id)
  end

  private

  def segment_params
    params.require(:segment).permit(:content, :content_type, :lesson_id, :place_value)
  end
end
