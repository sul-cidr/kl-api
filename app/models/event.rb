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
#

class Event < ActiveRecord::Base

  has_many :person_events
  has_many :people, :through => :person_events
  belongs_to :event_type

  validates :legacy_id, uniqueness: true

end
