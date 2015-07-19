
module API
  class RelationController < ApplicationController

    def index
      @people = Graph::Person.kin(
        params[:source].to_i,
        params[:target].to_i
      )
    end

  end
end
