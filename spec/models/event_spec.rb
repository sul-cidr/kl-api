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

  describe "after_year" do

    it "returns events after the passed year" do

      e1 = create(:event, year: 1801)
      e2 = create(:event, year: 1802)
      e3 = create(:event, year: 1803)
      e4 = create(:event, year: 1804)

      events = Event.after_year(1802)

      expect(events[0].id).to eq(e3.id)
      expect(events[1].id).to eq(e4.id)
      expect(events.length).to eq(2)

    end

  end

end
