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
    it { should validate_uniqueness_of(:legacy_id) }
    it { should have_many(:person_events) }
    it { should have_many(:people).through(:person_events) }
  end

end
