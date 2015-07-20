
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

      if params[:people]
        events = events.by_people(params[:people])
      end

      if params[:occupations]
        events = events.by_occupations(params[:occupations])
      end

      if params[:types]
        events = events.by_types(params[:types])
      end

      if params[:source] and params[:steps]
        ids = Graph::Person.bacon(params[:source].to_i, params[:steps].to_i)
        events = events.by_people(ids)
      end

      @events = paginate(events)

    end

  end
end
