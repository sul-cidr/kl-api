
module API
  class BaconController < ApplicationController

    def index
      @ids = Graph::Person.bacon(
        params[:source].to_i,
        params[:steps].to_i,
      )
    end

  end
end
