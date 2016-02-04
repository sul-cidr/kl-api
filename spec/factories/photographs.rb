# == Schema Information
#
# Table name: photographs
#
#  id                   :integer          not null, primary key
#  lonlat               :geometry({:srid= point, 0
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  flickr_id            :integer          not null
#  url                  :string           not null
#  title                :string
#  address              :string
#  needs_coord          :boolean          default(FALSE), not null
#  license              :integer
#  copyright_permission :boolean
#  fee                  :string
#  credit               :string
#  accuracy             :integer
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
