
module V1
  class PeopleController < ApplicationController

    def index
      @people = [
        { family_name: "McClure", given_name: "David" },
        { family_name: "Weisman", given_name: "Kara" }
      ]
    end

  end
end
