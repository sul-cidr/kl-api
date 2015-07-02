
module V1
  class PeopleController < ApplicationController

    def index
      @people = paginate(Person.all)
    end

  end
end
