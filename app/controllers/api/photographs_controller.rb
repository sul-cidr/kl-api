
module API
  class PhotographsController < ApplicationController

    def index
      @photographs = paginate(Photograph.all)
    end

  end
end
