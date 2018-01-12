class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = User.find(params[:user_id]).events.between(params['start'], params['end']) if (params['start'] && params['end']) #eventsに関するpathはuser/eventsのみ

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @events }
      format.json { render :json => @events}
    end
  end

  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      @event.update(events_params)
      format.html {render :nothing => true}
      format.js{render :nothing => true}
    end
  end

  private
    def events_params
      #params.require(:event).permit(:title,:user_id, :id, consultation: [:id, :memo, :client_id, :consultant_id, :data, :data_cache, :remove_data])
      params.require(:event).permit(:title,:user_id, :id, :planed_start, :planed_end, :actual_start, :actual_end)
    end
end
