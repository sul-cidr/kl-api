
module API
  class RelationController < ApplicationController

    def index

      ids = Graph::Person.kin(
        params[:source].to_i,
        params[:target].to_i
      )

      @people = ids.map do |id|
        Person.find(id)
      end

    end

  end
end
