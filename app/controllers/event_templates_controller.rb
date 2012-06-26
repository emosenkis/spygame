class EventTemplatesController < ApplicationController
  def new
    @event_template = EventTemplate.new
    @event_template.mission_template_id = params[:id]
  end
end
