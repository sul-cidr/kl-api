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
        create(:event, year: 1803)
        create(:event, year: 1804)

        events = Event.after_year(1802)

        expect(events[0].year).to eq(1803)
        expect(events[1].year).to eq(1804)
        expect(events.length).to eq(2)

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

end
