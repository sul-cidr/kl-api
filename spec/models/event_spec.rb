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
        e1 = create(:event, year: 1803)
        e2 = create(:event, year: 1804)

        events = Event.after_year(1802)
        expect(events).to be_records(e1, e2)

      end

      it "when dates are defined" do

        create(:event, date: Date.new(1801))
        create(:event, date: Date.new(1802))
        create(:event, date: Date.new(1803))
        create(:event, date: Date.new(1804))

        events = Event.after_year(1802)

        expect(events[0].date.year).to eq(1803)
        expect(events[1].date.year).to eq(1804)
        expect(events.length).to eq(2)

      end

      it "when years and dates are mixed" do

        create(:event, year: 1801)
        create(:event, date: Date.new(1802))
        create(:event, year: 1803)
        create(:event, date: Date.new(1804))

        events = Event.after_year(1802)

        expect(events[0].year).to eq(1803)
        expect(events[1].date.year).to eq(1804)
        expect(events.length).to eq(2)

      end

    end

  end

  describe ".before_year()" do

    describe "returns events before the passed year" do

      it "when years are defined" do

        create(:event, year: 1801)
        create(:event, year: 1802)
        create(:event, year: 1803)
        create(:event, year: 1804)

        events = Event.before_year(1803)

        expect(events[0].year).to eq(1801)
        expect(events[1].year).to eq(1802)
        expect(events.length).to eq(2)

      end

      it "when dates are defined" do

        create(:event, date: Date.new(1801))
        create(:event, date: Date.new(1802))
        create(:event, date: Date.new(1803))
        create(:event, date: Date.new(1804))

        events = Event.before_year(1803)

        expect(events[0].date.year).to eq(1801)
        expect(events[1].date.year).to eq(1802)
        expect(events.length).to eq(2)

      end

      it "when years and dates are mixed" do

        create(:event, year: 1801)
        create(:event, date: Date.new(1802))
        create(:event, year: 1803)
        create(:event, date: Date.new(1804))

        events = Event.before_year(1803)

        expect(events[0].year).to eq(1801)
        expect(events[1].date.year).to eq(1802)
        expect(events.length).to eq(2)

      end

    end

  end

  describe ".in_extent()", :helpers => :geo do

    it "returns event inside of the passed polygon" do

      create(:event, lonlat: point(1, 1))
      create(:event, lonlat: point(1, 2))
      create(:event, lonlat: point(1, 4))
      create(:event, lonlat: point(1, 5))

      extent = polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      events = Event.in_extent(extent.to_s)

      expect(events[0].lonlat.x).to eq(1)
      expect(events[0].lonlat.y).to eq(1)
      expect(events[1].lonlat.x).to eq(1)
      expect(events[1].lonlat.y).to eq(2)
      expect(events.length).to eq(2)

    end

  end

end
