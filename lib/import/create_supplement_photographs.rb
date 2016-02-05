
module Import
  class CreateSupplementPhotographs < Step

    def up
      csv('photos/supplement.csv').each do |row|

        @old = row
        @new = Photograph.new

        set_flickr_id
        set_unchanged_fields
        set_lonlat

        @new.save

      end
    end

    #
    # Parse out the Flickr id.
    #
    def set_flickr_id
      @new.flickr_id = @old['Flickr URL'].scan(/[0-9]+/)[-1]
    end

    #
    # Set origin / descriptive fields.
    #
    def set_unchanged_fields
      @new.attributes = {
        title: @old['photo title'],
        url: @old['Flickr URL'],
      }
    end

    #
    # Set the coordinate, if provided.
    #
    def set_lonlat

      point = @old['co-ordinates'].split(',')

      if point.length == 2 and point[0] != '['

        @new.lonlat = Helpers::Geo.point(
          point[0].to_f,
          point[1].to_f,
        )

        @new.accuracy = 0

      end

    end

    def down
      Photograph.delete_all
    end

  end
end
