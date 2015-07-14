# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legacy_id     :integer
#  event_type_id :integer
#  year          :integer
#  date          :date
#  lonlat        :geometry({:srid= point, 0
#  description   :text
#

require 'rails_helper'

describe Event, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of(:legacy_id) }
  end

  describe "associations" do
    it { should have_many(:person_events) }
    it { should have_many(:people).through(:person_events) }
    it { should belong_to(:event_type) }
  end

  describe ".after_year()" do

    describe "returns events after the passed year" do

      it "when years are defined" do

        create(:event, year: 1801)
        create(:event, year: 1802)
        e3 = create(:event, year: 1803)
        e4 = create(:event, year: 1804)

        events = Event.after_year(1802)
        expect(events).to be_records(e3, e4)

      end

      it "when dates are defined" do

        create(:event, date: Date.new(1801))
        create(:event, date: Date.new(1802))
        e3 = create(:event, date: Date.new(1803))
        e4 = create(:event, date: Date.new(1804))

        events = Event.after_year(1802)
        expect(events).to be_records(e3, e4)

      end

      it "when years and dates are mixed" do

        create(:event, year: 1801)
        create(:event, date: Date.new(1802))
        e3 = create(:event, year: 1803)
        e4 = create(:event, date: Date.new(1804))

        events = Event.after_year(1802)
        expect(events).to be_records(e3, e4)

      end

    end

  end

  describe ".before_year()" do

    describe "returns events before the passed year" do

      it "when years are defined" do

        e1 = create(:event, year: 1801)
        e2 = create(:event, year: 1802)
        create(:event, year: 1803)
        create(:event, year: 1804)

        events = Event.before_year(1803)
        expect(events).to be_records(e1, e2)

      end

      it "when dates are defined" do

        e1 = create(:event, date: Date.new(1801))
        e2 = create(:event, date: Date.new(1802))
        create(:event, date: Date.new(1803))
        create(:event, date: Date.new(1804))

        events = Event.before_year(1803)
        expect(events).to be_records(e1, e2)

      end

      it "when years and dates are mixed" do

        e1 = create(:event, year: 1801)
        e2 = create(:event, date: Date.new(1802))
        create(:event, year: 1803)
        create(:event, date: Date.new(1804))

        events = Event.before_year(1803)
        expect(events).to be_records(e1, e2)

      end

    end

  end

  describe ".in_extent()", :helpers => :geo do

    it "returns events inside of the passed polygon" do

      e1 = create(:event, lonlat: point(1, 1))
      e2 = create(:event, lonlat: point(1, 2))
      create(:event, lonlat: point(1, 4))
      create(:event, lonlat: point(1, 5))

      extent = polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      events = Event.in_extent(extent.to_s)
      expect(events).to be_records(e1, e2)

    end

  end

  describe ".in_radius()", :helpers => :geo do

    it "returns events with a given radius of a point" do

      e1 = create(:event, lonlat: point(1, 0))
      e2 = create(:event, lonlat: point(2, 0))
      create(:event, lonlat: point(4, 0))
      create(:event, lonlat: point(5, 0))

      center = point(0, 0)

      events = Event.in_radius(center.to_s, 3)
      expect(events).to be_records(e1, e2)

    end

  end

  describe ".by_occupation()" do
    it "returns events associated with people of a given occupation"
  end

  describe ".by_type()" do

    xit "returns events of a given type" do

      t1 = create(:event_type_with_events)
      create(:event_type_with_events)

      events = Event.by_type(t1.id)
      expect(events).to be_records(t1.events)

    end

  end

end
