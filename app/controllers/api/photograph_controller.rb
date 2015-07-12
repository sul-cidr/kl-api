
module API
  class PhotographController < ApplicationController

    def index
      @photographs = paginate(Photograph.all)
    end

  end
end
