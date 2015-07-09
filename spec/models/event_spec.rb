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
#  year_est      :boolean
#

require 'rails_helper'

describe Event, type: :model do

  describe "validations" do

    it "should reject duplicate legacy_ids" do
      Event.create(legacy_id: 1)
      expect(Event.new(legacy_id: 1)).not_to be_valid
      expect(Event.new(legacy_id: 2)).to be_valid
    end

  end

end
