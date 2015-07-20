
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

    it "start_year" do

      create(:event, year: 1801)
      create(:event, year: 1802)
      e3 = create(:event, year: 1803)
      e4 = create(:event, year: 1804)

      get :index, start_year: 1803
      expect(response.body).to be_json_records(e3, e4)

    end

    it "end_year" do

      e1 = create(:event, year: 1801)
      e2 = create(:event, year: 1802)
      create(:event, year: 1803)
      create(:event, year: 1804)

      get :index, end_year: 1802
      expect(response.body).to be_json_records(e1, e2)

    end

    it "extent" do

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

    it "lon+lat+radius" do

      e1 = create(:event, lonlat: GeoHelper.point(1, 0))
      e2 = create(:event, lonlat: GeoHelper.point(2, 0))
      create(:event, lonlat: GeoHelper.point(4, 0))
      create(:event, lonlat: GeoHelper.point(5, 0))

      get :index, lon: 0, lat: 0, radius: 3
      expect(response.body).to be_json_records(e1, e2)

    end

    describe "people" do

      before do

        @p1 = create(:person)
        @p2 = create(:person)
        @p3 = create(:person)

        @e1 = create(:event)
        @e2 = create(:event)
        @e3 = create(:event)
        @e4 = create(:event)
        @e5 = create(:event)
        @e6 = create(:event)

        create(:person_event, person: @p1, event: @e1)
        create(:person_event, person: @p1, event: @e2)
        create(:person_event, person: @p2, event: @e3)
        create(:person_event, person: @p2, event: @e4)
        create(:person_event, person: @p3, event: @e5)
        create(:person_event, person: @p3, event: @e6)

      end

      it "one person" do
        get :index, people: @p1.id
        expect(response.body).to be_json_records(@e1, @e2)
      end

      it "multiple people" do
        get :index, people: [@p1.id, @p2.id]
        expect(response.body).to be_json_records(@e1, @e2, @e3, @e4)
      end

    end

    it "occupation" do

      p1 = create(:person)
      p2 = create(:person)

      o1 = create(:occupation)
      o2 = create(:occupation)

      e1 = create(:event)
      e2 = create(:event)
      e3 = create(:event)
      e4 = create(:event)

      # occupation 1 -> person 1 -> events 1+2.
      # occupation 2 -> person 2 -> events 3+4.

      create(:person_occupation, person: p1, occupation: o1)
      create(:person_occupation, person: p2, occupation: o2)

      create(:person_event, person: p1, event: e1)
      create(:person_event, person: p1, event: e2)
      create(:person_event, person: p2, event: e3)
      create(:person_event, person: p2, event: e4)

      get :index, occupation: o1.id
      expect(response.body).to be_json_records(e1, e2)

    end

    it "type" do

      t1 = create(:event_type_with_events)
      create(:event_type_with_events)

      get :index, type: t1.id
      expect(response.body).to be_json_records(*t1.events)

    end

    it "source+steps", :neo4j, :quiet do

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)
      p4 = create(:person)
      p5 = create(:person)

      e1 = create(:event)
      e2 = create(:event)
      e3 = create(:event)
      e4 = create(:event)
      e5 = create(:event)

      create(:person_event, person: p1, event: e1)
      create(:person_event, person: p2, event: e2)
      create(:person_event, person: p3, event: e3)
      create(:person_event, person: p4, event: e4)
      create(:person_event, person: p5, event: e5)

      n1 = Graph::Person.add_node(p1.id)
      n2 = Graph::Person.add_node(p2.id)
      n3 = Graph::Person.add_node(p3.id)
      n4 = Graph::Person.add_node(p4.id)
      n5 = Graph::Person.add_node(p5.id)

      n1.child << n2
      n2.child << n3
      n3.child << n4
      n4.child << n5

      get :index, source: p1.id, steps: 1
      expect(response.body).to be_json_records(e2)

      get :index, source: p1.id, steps: 2
      expect(response.body).to be_json_records(e2, e3)

      get :index, source: p1.id, steps: 3
      expect(response.body).to be_json_records(e2, e3, e4)

      get :index, source: p1.id, steps: 4
      expect(response.body).to be_json_records(e2, e3, e4, e5)

    end

  end

end
