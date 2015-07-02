
require 'rails_helper'

describe V1::PeopleController, type: :controller do

  describe "GET #index" do

    it "provides a list of people" do
      request.headers["Accept"] = "application/json; version=1"
      get :index
      # TODO
    end

  end

end
