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

FactoryGirl.define do

  sequence :photograph_flickr_id do |n|
    n
  end

  sequence :photograph_flickr_url do |n|
    "http://flickr.com/#{n}"
  end

  factory :photograph do

    flickr_id { generate(:photograph_flickr_id) }
    flickr_url { generate(:photograph_flickr_url) }

  end

end
