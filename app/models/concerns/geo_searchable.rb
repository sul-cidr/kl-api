
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
      point = GeoHelper.point(lon, lat)
      where("ST_DWithin(ST_GeomFromText(?), lonlat, ?)", point.to_s, radius)
    end

    #
    # DEV: Write random, London-ish coordinates onto the rows.
    #
    # @param min_lon [Float]
    # @param max_lon [Float]
    # @param min_lat [Float]
    # @param max_lat [Float]
    #
    def stub_lonlats(min_lon=-0.5, max_lon=0.2, min_lat=51.2, max_lat=51.7)

      bar = ProgressBar.new(count)

      all.each do |row|

        # Set a random coordinate.
        row.lonlat = GeoHelper.point(
          rand(min_lon..max_lon),
          rand(min_lat..max_lat)
        )

        row.save
        bar.increment!

      end

    end

  end

end
