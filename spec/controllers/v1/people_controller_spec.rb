
require 'rails_helper'

describe V1::PeopleController, type: :controller do

  before(:each) do
    request.headers["Accept"] = "application/json; version=1"
  end

  describe "GET #index" do

    it "provides a list of people" do
      get :index
      # TODO
    end

  end

end
