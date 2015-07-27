
module Import
  class CreatePhotographs < Step

    @depends = []

    def up

      # Form the CSV path.
      path = Rails.root.join("data/photographs.csv")

      CSV.foreach(path, :headers => true) do |row|

        @old = row
        @new = Photograph.new

        set_unchanged_cols
        set_lonlat

        @new.save

      end

    end

    #
    # Set directly-migrated column values.
    #
    def set_unchanged_cols
      @new.attributes = {
        flickr_id: @old["photo_id"],
        url: @old["img_orig"],
      }
    end

    #
    # Set the coordinate, if provided.
    #
    def set_lonlat

      point = eval(@old["coordinates"])

      if point[0] != ""
        @new.lonlat = Helpers::Geo.point(
          point[0].to_f,
          point[1].to_f,
        )
      end

    end

    def down
      Photograph.delete_all
    end

    def satisfied?
      #Photograph.count > 0
      false
    end

  end
end
