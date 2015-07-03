
module API
  class PeopleController < ApplicationController

    def index
      @people = paginate(Person.all)
    end

  end
end
