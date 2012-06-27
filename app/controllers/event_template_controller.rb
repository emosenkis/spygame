class EventTemplateController < ApplicationController

  def show
    @event_temp = EventTemplate.find(params[:id])
  end

  def new
    @event_temp = EventTemplate.new
  end

  def create
    @event_temp = EventTemplate.new(params[:event_template])
    if @event_temp.save
      flash[:success] = "event created"
      redirect_to @event_temp
    else
    	flash[:error] = @event_temp.errors
      render 'new'
    end
  end

  def edit
  end

  def index
    @event_temps = EventTemplate.all
  end

  def destroy
    EventTemplate.find(params[:id]).destroy
    flash[:success] = "Event destroyed."
    redirect_to event_templates_path
  end

  def update
    if @event_temp.update_attributes(params[:event_template])
      flash[:success] = "event updated"
      redirect_to @event_temp
    else
      render 'edit'
    end
  end

 end
end
