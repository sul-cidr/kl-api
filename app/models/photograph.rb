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
#  image_url       :string
#  fsize_url       :string
#  thumb_url       :string
#  harvested       :boolean
#

class Photograph < ActiveRecord::Base

  include GeoSearchable

  validates :flickr_id, presence: true, uniqueness: true
  validates :flickr_url, presence: true

  #
  # Download photos from Flickr.
  #
  def self.harvest()

    photos = Rails.public_path.join('photos')

    # Create the directory.
    unless File.directory?(photos)
      FileUtils.mkdir_p(photos)
    end

    where{harvested == nil}.order{id}.each do |p|

      puts p.id

      begin

        # Download the file.

        sizes = flickr.photos.getSizes(photo_id: p.flickr_id)

        original = sizes.find do |s|
          s.label == 'Original'
        end

        path = photos.join("#{p.flickr_id}.jpg")

        File.open(path, 'wb') do |f|
          f.print(open(original.source).read)
        end

        # Set the coordinate, if missing.

        if not p.lonlat

          geo = flickr.photos.geo.getLocation(photo_id: p.flickr_id)

          p.lonlat = Helpers::Geo.point(
            geo.location.longitude.to_f,
            geo.location.latitude.to_f,
          )

        end

        p.harvested_url = original.source
        p.harvested = true

      rescue => error

        puts "Failed: #{p.flickr_id}"
        pp error

        p.harvested = false

      end

      p.save!

    end

  end

end
