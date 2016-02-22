
require 'rails_helper'

describe API::LandmarksController, type: :controller do

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "extent" do

      lm1 = create(:landmark, lonlat: Helpers::Geo.point(1, 1))
      lm2 = create(:landmark, lonlat: Helpers::Geo.point(1, 2))
      create(:landmark, lonlat: Helpers::Geo.point(1, 4))
      create(:landmark, lonlat: Helpers::Geo.point(1, 5))

      extent = Helpers::Geo.polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      get :index, extent: extent.to_s
      expect(response.body).to be_json_records(lm1, lm2)

    end

    it "lon+lat+radius" do

      lm1 = create(:landmark, lonlat: Helpers::Geo.point(1, 0))
      lm2 = create(:landmark, lonlat: Helpers::Geo.point(2, 0))
      create(:landmark, lonlat: Helpers::Geo.point(4, 0))
      create(:landmark, lonlat: Helpers::Geo.point(5, 0))

      get :index, lon: 0, lat: 0, radius: 3
      expect(response.body).to be_json_records(lm1, lm2)

    end

  end

end
