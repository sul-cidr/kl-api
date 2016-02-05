# == Schema Information
#
# Table name: photographs
#
#  id              :integer          not null, primary key
#  lonlat          :geometry({:srid= point, 0
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flickr_id       :integer          not null
#  url             :string           not null
#  title           :string
#  address         :string
#  license         :integer
#  permission      :boolean
#  fee             :string
#  credit          :string
#  accuracy        :integer
#  permission_date :date
#  place           :string
#  legacy_id       :string
#

class Photograph < ActiveRecord::Base

  include GeoSearchable

  validates :flickr_id, presence: true, uniqueness: true
  validates :url, presence: true

  #
  # Map geocoding results into the PostGIS point column.
  #
  geocoded_by :geoquery, :lookup => :google do |event, results|
    if geo = results.first
      event.lonlat = Helpers::Geo.point(geo.longitude, geo.latitude)
    end
  end

  #
  # Form a geocoding query.
  #
  def geoquery
    address or "#{title}, London"
  end

end
