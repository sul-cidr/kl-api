
module API
  class PhotographsController < ApplicationController

    def index

      photos = Photograph.all

      if params[:extent]
        photos = photos.in_extent(params[:extent])
      end

      if params[:lon] and params[:lat] and params[:radius]
        photos = photos.in_radius(
          params[:lon].to_i,
          params[:lat].to_i,
          params[:radius],
        )
      end

      @photographs = paginate(photos)

    end

  end
end
