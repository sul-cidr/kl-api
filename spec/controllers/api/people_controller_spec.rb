
require 'rails_helper'

describe API::PhotographsController, type: :controller do

  render_views

  let(:per_page) { 25 }

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "should return a list of photographs (with default pagination)" do

      # Create 100 photographs.
      create_list(:photograph, 100)

      get :index
      json = JSON.parse(response.body)

      # Should return first page.
      expect(json.length).to eq(per_page)

    end

  end

end
