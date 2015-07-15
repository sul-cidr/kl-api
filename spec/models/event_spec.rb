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

  describe "indexes" do
    it { should have_db_index(:legacy_id).unique(true) }
    it { should have_db_index(:event_type_id) }
    it { should have_db_index(:year) }
    it { should have_db_index(:date) }
    it { should have_db_index(:lonlat) }
  end

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

        events = Event.after_year(1803)
        expect(events).to be_records(e3, e4)

      end

      it "when dates are defined" do

        create(:event, date: Date.new(1801))
        create(:event, date: Date.new(1802))
        e3 = create(:event, date: Date.new(1803))
        e4 = create(:event, date: Date.new(1804))

        events = Event.after_year(1803)
        expect(events).to be_records(e3, e4)

      end

      it "when years and dates are mixed" do

        create(:event, year: 1801)
        create(:event, date: Date.new(1802))
        e3 = create(:event, year: 1803)
        e4 = create(:event, date: Date.new(1804))

        events = Event.after_year(1803)
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

        events = Event.before_year(1802)
        expect(events).to be_records(e1, e2)

      end

      it "when dates are defined" do

        e1 = create(:event, date: Date.new(1801))
        e2 = create(:event, date: Date.new(1802))
        create(:event, date: Date.new(1803))
        create(:event, date: Date.new(1804))

        events = Event.before_year(1802)
        expect(events).to be_records(e1, e2)

      end

      it "when years and dates are mixed" do

        e1 = create(:event, year: 1801)
        e2 = create(:event, date: Date.new(1802))
        create(:event, year: 1803)
        create(:event, date: Date.new(1804))

        events = Event.before_year(1802)
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

      events = Event.in_radius(0, 0, 3)
      expect(events).to be_records(e1, e2)

    end

  end

  describe ".by_people()" do

    it "returns events associated with a given set of people" do

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)

      e1 = create(:event)
      e2 = create(:event)
      e3 = create(:event)
      e4 = create(:event)
      e5 = create(:event)
      e6 = create(:event)

      create(:person_event, person: p1, event: e1)
      create(:person_event, person: p1, event: e2)
      create(:person_event, person: p2, event: e3)
      create(:person_event, person: p2, event: e4)
      create(:person_event, person: p3, event: e5)
      create(:person_event, person: p3, event: e6)

      events = Event.by_people(p1.id, p2.id)
      expect(events).to be_records(e1, e2, e3, e4)

    end

  end

  describe ".by_occupation()" do

    it "returns events associated with people of a given occupation" do

      p1 = create(:person)
      p2 = create(:person)

      o1 = create(:occupation)
      o2 = create(:occupation)

      e1 = create(:event)
      e2 = create(:event)
      e3 = create(:event)
      e4 = create(:event)

      # events 1&2 -> occupation 1 -> person 1.
      # events 3&4 -> occupation 2 -> person 2.

      create(:person_occupation, person: p1, occupation: o1)
      create(:person_occupation, person: p2, occupation: o2)

      create(:person_event, person: p1, event: e1)
      create(:person_event, person: p1, event: e2)
      create(:person_event, person: p2, event: e3)
      create(:person_event, person: p2, event: e4)

      events = Event.by_occupation(o1.id)
      expect(events).to be_records(e1, e2)

    end

  end

  describe ".by_type()" do

    it "returns events of a given type" do

      t1 = create(:event_type_with_events)
      create(:event_type_with_events)

      events = Event.by_type(t1.id)
      expect(events).to be_records(*t1.events)

    end

  end

end
