class EventTemplatesController < ApplicationController
	def show
		@event = EventTemplate.find(params[:id])
		
    	@next_event = @event.mission_template.event_templates.find_by_parent_event_id(@event.parent_event_id+1)
	end

end
