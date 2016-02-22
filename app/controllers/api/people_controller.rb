
module API
  class PeopleController < ApplicationController

    def index
      @people = paginate(Person.all)
    end

    def show
      @person = Person.find_by(id: params[:id])
    end

  end
end
