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
  # Match events inside of an arbitrary polygon.
  #
  # @param extent [String]
  #
  def self.in_extent(extent)
    where("ST_Contains(ST_GeomFromText(?), lonlat)", extent)
  end

  #
  # Match events within a radius around a point.
  #
  # @param lon [Float]
  # @param lat [Float]
  # @param radius [Float]
  #
  def self.in_radius(lon, lat, radius)
    point = GeoHelper.point(lon, lat)
    where("ST_DWithin(ST_GeomFromText(?), lonlat, ?)", point.to_s, radius)
  end

  #
  # Match events linked with a people.
  #
  # @param id [Integer]
  #
  def self.by_person(id)
    joins { people }.where {
      people.id == id
    }
  end

  #
  # Match events linked to people with a given occupation.
  #
  # @param id [Integer]
  #
  def self.by_occupation(id)
    joins { people.occupations }.where {
      occupations.id == id
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
