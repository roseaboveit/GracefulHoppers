class UnitsController < ApplicationController

  before_action :check_for_admin, only: [:new, :create, :edit, :update]

  def new
    @unit = Unit.new
  end


  def create
    @unit = Unit.new(unit_params)
    if @unit.save
      redirect_to @unit
    else
      redirect_to new_unit_path, notice: "Remember to fill out all the fields."
    end
  end

  def show
    @unit = Unit.find(params[:id])
    if @unit.published == false
      check_for_admin
    elsif current_user
      if (current_user.admin? == false) && (@unit.id > current_user.unit)
        redirect_to unit_path(current_user.unit), notice: "Here's the unit you are currently on. Don't skip ahead."
      else
        render :show
      end
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
  end

  def index
    @units = Unit.all
    if current_user && current_user.admin?
      render :index
    elsif current_user
      redirect_to user_path(current_user.id), notice: "Select from your current or previously completed units"
    else
      redirect_to root_path, notice: "You are not authorized to view this page"
    end
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

  def publish
    @unit = Unit.find(params[:id])
    @unit.published = true
    @unit.save
    redirect_to units_path
  end

  private

  def unit_params
    params.require(:unit).permit(:description, :total_points, :published, :image)
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
