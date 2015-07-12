
module API
  class EventsController < ApplicationController

    def index
      @events = paginate(Event.all)
    end

  end
end
