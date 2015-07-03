
require 'rails_helper'
require 'spec_helper'

describe V1::PeopleController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json; version=1"
  end

  describe "GET #index" do

    before(:each) do
      create_list(:person, 100)
    end

    it "should provide a list of people (with default pagination)" do
      get :index
      json = JSON.parse(response.body)
      expect(json.length).to eq(25)
    end

  end

end
