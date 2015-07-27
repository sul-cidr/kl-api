
module Import
  class CreateLandmarks < Step

    @depends = []

    def up

      # Form the CSV path.
      path = Rails.root.join("data/landmarks.csv")

      CSV.foreach(path, :headers => true) do |row|

        lon = row["Long."].to_f
        lat = row["Lat."].to_f

        Landmark.create(
          name: row["Name of monument"],
          unveiled_year: row["Date of unveiling"],
          lonlat: Helpers::Geo.point(lon, lat),
        )

      end

    end

    def down
      Landmark.delete_all
    end

    def satisfied?
      Landmark.count > 0
    end

  end
end
