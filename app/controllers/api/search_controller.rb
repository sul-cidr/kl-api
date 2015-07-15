
module API
  class SearchController < ApplicationController

    def index

      @results = Sunspot.search Person, Landmark, Occupation do
        fulltext params[:q] do
          highlight :name
        end
      end

    end

  end
end
