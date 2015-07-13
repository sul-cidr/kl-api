
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

    #
    # Create a polygon from an (unclosed) set of points.
    #
    def polygon(*coords)

      # Close the point set.
      coords << coords[0]

      # Because of a bug in RGeo, we have to pass a LINESTRING to the polygon
      # factory, instead of just an array of points.
      geo.polygon(geo.line_string(
        coords.map do |c|
          point(*c)
        end
      ))

    end

  end
end
