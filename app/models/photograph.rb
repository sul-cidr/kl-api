# == Schema Information
#
# Table name: photographs
#
#  id         :integer          not null, primary key
#  lonlat     :geometry({:srid= point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  flickr_id  :integer          not null
#  url        :string           not null
#  title      :string
#  address    :string
#

class Photograph < ActiveRecord::Base

  include GeoSearchable

  validates :flickr_id, presence: true, uniqueness: true
  validates :url, presence: true

  #
  # Map geocoding results into the PostGIS point column.
  #
  geocoded_by :geoquery do |event, results|
    if geo = results.first
      event.geometry = Helpers::Geo.point(geo.longitude, geo.latitude)
    end
  end

  #
  # Form a geocoding query.
  #
  def geoquery
    address or "#{title}, London"
  end

end
