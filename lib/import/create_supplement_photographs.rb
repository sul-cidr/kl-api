
module Import
  class CreateSupplementPhotographs < Step

    @depends = [CreatePhotographs]

    def up
      csv('photos/supplement.csv').each do |row|

        @old = row
        @new = Photograph.new

        set_flickr_id
        set_unchanged_fields
        set_lonlat
        set_permission_fields

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
        title:      @old['photo title'],
        legacy_id:  @old['KB Association'],
        flickr_url: @old['Flickr URL'],
        accuracy:   @old['Accuracy'],
        place:      @old['Rough address'],
        notes:      @old['notes'],
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

      end

    end

    #
    # Set copyright / permission fields.
    #
    def set_permission_fields

      if @old['permission given'] == 'yes'
        @new.permission = true
      end

      if @old['date of permission']
        parsed = Date.strptime(@old['date of permission'], '%m/%d/%y')
        @new.permission_date = parsed
      end

    end

    def down
      Photograph.delete_all
    end

  end
end
