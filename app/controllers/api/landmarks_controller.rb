
module API
  class LandmarksController < ApplicationController

    def index
      @landmarks = paginate(Landmark.all)
    end

  end
end
