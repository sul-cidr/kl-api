
module API
  class LandmarksController < ApplicationController

    def index

      landmarks = Landmark.all

      if params[:extent]
        landmarks = landmarks.in_extent(params[:extent])
      end

      if params[:lon] and params[:lat] and params[:radius]
        landmarks = landmarks.in_radius(
          params[:lon].to_i,
          params[:lat].to_i,
          params[:radius],
        )
      end

      if params[:types]
        landmarks = landmarks.by_types(params[:types])
      end

      @landmarks = paginate(landmarks)

    end

  end
end
