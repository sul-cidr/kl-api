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
  belongs_to :event_type

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
  # Match events linked with a people.
  #
  # @param ids [Integer]
  #
  def self.by_people(*ids)
    joins { people }.where {
      people.id >> ids
    }
  end

  #
  # Match events linked to people with a given occupation.
  #
  # @param ids [Integer]
  #
  def self.by_occupations(*ids)
    joins { people.occupations }.where {
      occupations.id >> ids
    }
  end

  #
  # Match events of a given type.
  #
  # @param id [Integer]
  #
  def self.by_type(id)
    where { event_type_id == id }
  end

end
