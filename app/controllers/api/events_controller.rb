
module API
  class EventsController < ApplicationController

    def index

      events = Event.all

      if params[:after]
        events = events.after_year(params[:after])
      end

      if params[:before]
        events = events.before_year(params[:before])
      end

      if params[:extent]
        events = events.in_extent(params[:extent])
      end

      @events = paginate(events)

    end

  end
end
