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

class Event < ActiveRecord::Base

  include GeoSearchable

  has_many :person_events
  has_many :people, :through => :person_events

  belongs_to :type, class_name: :EventType, foreign_key: "event_type_id"

  validates :legacy_id, uniqueness: true

  #
  # Match events that occur after a given year (inclusive).
  #
  # @param y [Integer]
  #
  def self.after_year(y)
    where {
      ((year >= y) & (date == nil)) |
      ((date >= Date.new(y)) & (year == nil))
    }
  end

  #
  # Match events that occur before a given year (inclusive).
  #
  # @param y [Integer]
  #
  def self.before_year(y)
    where {
      ((year <= y) & (date == nil)) |
      ((date <= Date.new(y)) & (year == nil))
    }
  end

  #
  # Match events linked with 1+ people.
  #
  # @param ids [Integer]
  #
  def self.by_people(*ids)
    joins { people }.where {
      people.id >> ids
    }
  end

  #
  # Match events linked to people of 1+ occupations.
  #
  # @param ids [Integer]
  #
  def self.by_occupations(*ids)
    joins { people.occupations }.where {
      occupations.id >> ids
    }
  end

  #
  # Match events of 1+ types.
  #
  # @param ids [Integer]
  #
  def self.by_types(*ids)
    where { event_type_id >> ids }
  end

end
