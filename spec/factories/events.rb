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

FactoryGirl.define do

  factory :event do

    name        "Event Name"
    description "Event description."

    sequence :legacy_id do |n|
      n
    end

  end

end
