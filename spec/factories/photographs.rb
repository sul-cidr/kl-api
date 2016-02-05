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

FactoryGirl.define do

  sequence :photograph_flickr_id do |n|
    n
  end

  sequence :photograph_url do |n|
    "http://flickr.com/#{n}"
  end

  factory :photograph do

    flickr_id { generate(:photograph_flickr_id) }
    url { generate(:photograph_url) }

  end

end
