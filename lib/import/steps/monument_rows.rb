
module Import
  class MonumentRows < Step

    @depends = []

    def up

      # Form the CSV path.
      path = Rails.root.join("data/monuments.csv")

      CSV.foreach(path, :headers => true) do |row|

        lon = row["Long."].to_f
        lat = row["Lat."].to_f

        Monument.create(
          name: row["Name of monument"],
          unveiled_year: row["Date of unveiling"],
          lonlat: GeoHelper.point(lon, lat),
        )

      end

    end

    def down
      Monument.delete_all
    end

    def satisfied?
      Monument.count > 0
    end

  end
end
