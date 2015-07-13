
module Helpers
  module Geo

    #
    # Alias the cartesian geometry factory.
    #
    # returns [RGeo::Geos::CAPIFactory]
    #
    def geo
      RGeo::Cartesian.preferred_factory
    end

    #
    # Create a point geometry.
    #
    # @param x [Float]
    # @param y [Float]
    # @returns [RGeo::Geos::CAPIPointImpl]
    #
    def point(x, y)
      geo.point(x, y)
    end

  end
end
