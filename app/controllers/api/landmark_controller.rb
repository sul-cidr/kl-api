
module API
  class LandmarkController < ApplicationController

    def index
      @landmarks = paginate(Landmark.all)
    end

  end
end
