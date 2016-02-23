# == Schema Information
#
# Table name: photographs
#
#  id              :integer          not null, primary key
#  lonlat          :geometry({:srid= point, 0
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flickr_id       :integer          not null
#  flickr_url      :string           not null
#  title           :string
#  address         :string
#  license         :integer
#  permission      :boolean
#  fee             :string
#  credit          :string
#  accuracy        :integer
#  permission_date :date
#  place           :string
#  legacy_id       :string
#  notes           :text
#

class Photograph < ActiveRecord::Base

  include GeoSearchable

  validates :flickr_id, presence: true, uniqueness: true
  validates :flickr_url, presence: true

  #
  # Download photos from Flickr.
  #
  def self.harvest(delay=0.5)

    photos = Rails.public_path.join('photos')

    # Create the directory.
    unless File.directory?(photos)
      FileUtils.mkdir_p(photos)
    end

    bar = ProgressBar.new(all.count)

    all.each do |p|

      begin

        # Download the file.

        sizes = flickr.photos.getSizes(photo_id: p.flickr_id)

        fsize = sizes.find {|s| s.label == 'Large' }
        thumb = sizes.find {|s| s.label == 'Large Square' }

        fsize_path = photos.join("#{p.flickr_id}.jpg")
        thumb_path = photos.join("#{p.flickr_id}-thumb.jpg")

        # Fullsize
        File.open(fsize_path, 'wb') do |f|
          f.print(open(fsize.source).read)
        end

        # Thumbnail
        File.open(thumb_path, 'wb') do |f|
          f.print(open(thumb.source).read)
        end

        # Set the coordinate, if missing.

        if not p.lonlat

          geo = flickr.photos.geo.getLocation(photo_id: p.flickr_id)

          p.lonlat = Helpers::Geo.point(
            geo.location.longitude.to_f,
            geo.location.latitude.to_f,
          )

        end

      rescue
        puts "Failed: #{p.flickr_id}"
      end

      bar.increment!

      # Throttle.
      sleep(delay)

    end

  end

end
