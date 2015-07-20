
require 'rails_helper'

describe API::LandmarksController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "extent" do

      lm1 = create(:landmark, lonlat: GeoHelper.point(1, 1))
      lm2 = create(:landmark, lonlat: GeoHelper.point(1, 2))
      create(:landmark, lonlat: GeoHelper.point(1, 4))
      create(:landmark, lonlat: GeoHelper.point(1, 5))

      extent = GeoHelper.polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      get :index, extent: extent.to_s
      expect(response.body).to be_json_records(lm1, lm2)

    end

    it "lon+lat+radius" do

      lm1 = create(:landmark, lonlat: GeoHelper.point(1, 0))
      lm2 = create(:landmark, lonlat: GeoHelper.point(2, 0))
      create(:landmark, lonlat: GeoHelper.point(4, 0))
      create(:landmark, lonlat: GeoHelper.point(5, 0))

      get :index, lon: 0, lat: 0, radius: 3
      expect(response.body).to be_json_records(lm1, lm2)

    end

    describe "types" do

      before do
        @t1 = create(:landmark_type_with_landmarks)
        @t2 = create(:landmark_type_with_landmarks)
        @t3 = create(:landmark_type_with_landmarks)
      end

      it "one type" do
        get :index, types: @t1.id
        expect(response.body).to be_json_records(*@t1.landmarks)
      end

      it "multiple types" do
        get :index, types: [@t1.id, @t2.id]
        expect(response.body).to be_json_records(*@t1.landmarks+@t2.landmarks)
      end

    end

  end

end
