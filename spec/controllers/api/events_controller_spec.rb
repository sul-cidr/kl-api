
require 'rails_helper'

describe API::EventsController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "returns all events by default" do

      events = create_list(:event, 10)

      get :index
      expect(response.body).to be_json_records(*events)

    end

    it "returns events after `start_date`" do

      create(:event, year: 1801)
      create(:event, year: 1802)
      e3 = create(:event, year: 1803)
      e4 = create(:event, year: 1804)

      get :index, start_date: 1803
      expect(response.body).to be_json_records(e3, e4)

    end

    it "returns events before `end_date`" do

      e1 = create(:event, year: 1801)
      e2 = create(:event, year: 1802)
      create(:event, year: 1803)
      create(:event, year: 1804)

      get :index, end_date: 1802
      expect(response.body).to be_json_records(e1, e2)

    end

  end

end
