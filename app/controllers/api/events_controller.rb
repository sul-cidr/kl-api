
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

      if params[:lon] and params[:lat] and params[:radius]
        events = events.in_radius(
          params[:lon].to_i,
          params[:lat].to_i,
          params[:radius],
        )
      end

      if params[:person]
        events = events.by_person(params[:person])
      end

      if params[:occupation]
        events = events.by_occupation(params[:occupation])
      end

      @events = paginate(events)

    end

  end
end
