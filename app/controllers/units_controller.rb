class UnitsController < ApplicationController

  before_action :check_for_admin

  def new
    
  end


  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      redirect_to @unit
    else
      redirect_to new_unit_path, notice: "Remember to fill out the form before submitting."
    end
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def index
    @units = Unit.all
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update(unit_params)
      redirect_to unit_path(@unit)
    else
      redirect_to edit_unit_path(@unit)
    end
  end

  private

  def unit_params
    params.require(:unit).permit(:description, :total_points, :published)
  end

  def check_for_admin
    if current_user.nil?
      redirect_to root_path, notice: "You are not authorized to view this page"
    else
      unless current_user.admin?
        redirect_to root_path, notice: "You are not authorized to view this page"
      end
    end
  end

end
