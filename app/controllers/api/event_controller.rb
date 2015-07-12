
module API
  class EventController < ApplicationController

    def index
      @events = paginate(Event.all)
    end

  end
end
