
require 'rails_helper'

describe API::EventsController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "should return all events by default"

  end

end
