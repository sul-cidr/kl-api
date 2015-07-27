# == Schema Information
#
# Table name: photographs
#
#  id         :integer          not null, primary key
#  lonlat     :geometry({:srid= point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  flickr_id  :integer          not null
#

FactoryGirl.define do

  factory :photograph do

    sequence :flickr_id do |n|
      n
    end

  end

end
