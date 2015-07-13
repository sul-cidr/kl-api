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
  # Match events that occur after a given year.
  #
  # @param year [Integer]
  #
  def self.after_year(year)
    where("year > ?", year)
  end

  #
  # Match events that occur before a given year.
  #
  # @param year [Integer]
  #
  def self.before_year(year)
    where("year < ?", year)
  end

end
