# == Schema Information
#
# Table name: photographs
#
#  id         :integer          not null, primary key
#  slug       :string           not null
#  lonlat     :geometry({:srid= point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Photograph < ActiveRecord::Base

  validates :slug, presence: true, uniqueness: true

  #
  # Match photographs inside of an arbitrary polygon.
  #
  # @param extent [String]
  #
  def self.in_extent(extent)
    where("ST_Contains(ST_GeomFromText(?), lonlat)", extent)
  end

  #
  # Match photographs within a radius around a point.
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
