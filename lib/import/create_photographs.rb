
module Import
  class CreatePhotographs < Step

    def up
      csv('photos/master.csv').each do |row|

        @old = row
        @new = Photograph.new

        set_core_fields
        set_permission_fields
        set_lonlat

        @new.save

      end
    end

    #
    # Set origin / descriptive fields.
    #
    def set_core_fields
      @new.attributes = {
        flickr_id:  @old['photo_id'],
        url:        @old['img_orig'],
        address:    @old['address'],
        title:      @old['p_title'],
      }
    end

    #
    # Set copyright / permission fields.
    #
    def set_permission_fields

      rights = @old['copyright permission secured'] == 'yes' ?  true : nil

      @new.attributes = {
        license: @old['license'],
        copyright_permission: rights,
        fee: @old['fee?'],
      }

    end

    #
    # Set the coordinate, if provided.
    #
    def set_lonlat

      point = eval(@old['coordinates'])

      if point[0] != ''
        @new.lonlat = Helpers::Geo.point(
          point[0].to_f,
          point[1].to_f,
        )
      else
        @new.needs_coord = true
      end

    end

    def down
      Photograph.delete_all
    end

  end
end
