
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

    it "?start_year=YEAR" do

      create(:event, year: 1801)
      create(:event, year: 1802)
      e3 = create(:event, year: 1803)
      e4 = create(:event, year: 1804)

      get :index, start_year: 1803
      expect(response.body).to be_json_records(e3, e4)

    end

    it "?end_year=YEAR" do

      e1 = create(:event, year: 1801)
      e2 = create(:event, year: 1802)
      create(:event, year: 1803)
      create(:event, year: 1804)

      get :index, end_year: 1802
      expect(response.body).to be_json_records(e1, e2)

    end

    it "?extent=WKT" do

      e1 = create(:event, lonlat: GeoHelper.point(1, 1))
      e2 = create(:event, lonlat: GeoHelper.point(1, 2))
      create(:event, lonlat: GeoHelper.point(1, 4))
      create(:event, lonlat: GeoHelper.point(1, 5))

      extent = GeoHelper.polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      get :index, extent: extent.to_s
      expect(response.body).to be_json_records(e1, e2)

    end

  end

end
