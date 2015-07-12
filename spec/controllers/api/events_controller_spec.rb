
require 'rails_helper'

describe API::EventsController, type: :controller do

  render_views

  let(:per_page) { 25 }

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "should return a list of people (with default pagination)" do

      # Create 100 events.
      create_list(:event, 100)

      get :index
      json = JSON.parse(response.body)

      # Should return first page.
      expect(json.length).to eq(per_page)

    end

  end

end
