
module Import
  class ApplyPhotographCorrections < Step

    @depends = [CreatePhotographs, CreateSupplementPhotographs]

    def up

      table = csv('photos/fusion-table.csv').to_a
      fixes = csv('photos/corrections.csv').to_a

      table.zip(fixes).each do |row, fix|

        # Load the existing row.

        photo = Photograph.find_by(image_url: row['url'])

        # Patch in the metadata.

        photo.attributes = {
          legacy_id: fix['KB Association'],
          place: fix['Place'],
          accuracy: fix['Accuracy'],
          notes: fix['Notes'],
        }

        # Update the coordinate.

        point = fix['Revised co-ordinates'].split(',')

        photo.lonlat = Helpers::Geo.point(
          point[0].to_f,
          point[1].to_f,
        )

        photo.save

      end

    end

    def down
    end

  end
end
