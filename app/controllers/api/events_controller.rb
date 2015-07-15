
module API
  class EventsController < ApplicationController

    def index

      events = Event.all

      if params[:start_year]
        events = events.after_year(params[:start_year].to_i)
      end

      if params[:end_year]
        events = events.before_year(params[:end_year].to_i)
      end

      if params[:extent]
        events = events.in_extent(params[:extent])
      end

      @events = paginate(events)

    end

  end
end
