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
  def self.harvest
    puts 'harvest'
  end

end
