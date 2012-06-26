class MissionTemplatesController < ApplicationController
 before_filter :signed_in_user
 before_filter :admin_user,     only: [:edit, :update, :new, :create, :destroy]
 attr_accessor :title, :description

  def show
    @mission_template = MissionTemplate.find(params[:id])
  end

  def new
    @mission_template = MissionTemplate.new
  end

  def create
    @mission_template = MissionTemplate.new(params[:mission_template])
    if @mission_template.save
      flash[:success] = "Mission created."
      redirect_to @mission_template
    else
      flash[:error] = @mission_template.errors
      render 'new'
    end
  end

  def edit
    @mission_template = MissionTemplate.find(params[:id])
  end

  def index
    @mission_templates = MissionTemplate.all
  end

  def destroy
    MissionTemplate.find(params[:id]).destroy
    flash[:success] = "Mission destroyed."
    redirect_to mission_templates_path
  end

  def update
    if @mission_template.update_attributes(params[:mission_template])
      flash[:success] = "mission updated"
      redirect_to @mission_template
    else
      render 'edit'
    end
  end

 end
