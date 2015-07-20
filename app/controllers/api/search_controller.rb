
module API
  class SearchController < ApplicationController

    def index

      people = Sunspot.search Person do
        fulltext params[:query] do
          highlight :name
        end
      end

      landmarks = Sunspot.search Landmark do
        fulltext params[:query] do
          highlight :name
        end
      end

      occupations = Sunspot.search Occupation do
        fulltext params[:query] do
          highlight :name
        end
      end

      @results = {
        people: people,
        landmarks: landmarks,
        occupations: occupations
      }

    end

  end
end
