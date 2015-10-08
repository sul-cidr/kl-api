
module GeoSearchable

  extend ActiveSupport::Concern

  module ClassMethods

    #
    # Match events inside of an arbitrary polygon.
    #
    # @param extent [String]
    #
    def in_extent(extent)
      where("ST_Contains(ST_GeomFromText(?), lonlat)", extent)
    end

    #
    # Match events within a radius around a point.
    #
    # @param lon [Float]
    # @param lat [Float]
    # @param radius [Float]
    #
    def in_radius(lon, lat, radius)
      point = Helpers::Geo.point(lon, lat)
      where("ST_DWithin(ST_GeomFromText(?), lonlat, ?)", point.to_s, radius)
    end

  end

end
