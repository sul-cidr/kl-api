
module Import
  class CreateSupplementPhotographs < Step

    def up
      csv('photos/supplement.csv').each do |row|

        @old = row
        @new = Photograph.new

        set_flickr_id
        set_unchanged_fields

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
        url: 'url',
      }
    end

    def down
      Photograph.delete_all
    end

  end
end
