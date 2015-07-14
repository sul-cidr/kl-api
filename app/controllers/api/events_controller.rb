
module API
  class EventsController < ApplicationController

    def index

      events = Event.all

      if params[:start_date]
        events = events.after_year(params[:start_date].to_i)
      end

      if params[:end_date]
        events = events.before_year(params[:end_date].to_i)
      end

      @events = paginate(events)

    end

  end
end
