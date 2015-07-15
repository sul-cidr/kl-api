# == Schema Information
#
# Table name: landmarks
#
#  id               :integer          not null, primary key
#  name             :string
#  landmark_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  lonlat           :geometry({:srid= point, 0
#

class Landmark < ActiveRecord::Base

  belongs_to :landmark_type

  #
  # Match landmarks inside of an arbitrary polygon.
  #
  # @param extent [String]
  #
  def self.in_extent(extent)
    where("ST_Contains(ST_GeomFromText(?), lonlat)", extent)
  end

  #
  # Match landmarks within a radius around a point.
  #
  # @param lon [Float]
  # @param lat [Float]
  # @param radius [Float]
  #
  def self.in_radius(lon, lat, radius)
    point = GeoHelper.point(lon, lat)
    where("ST_DWithin(ST_GeomFromText(?), lonlat, ?)", point.to_s, radius)
  end

end
