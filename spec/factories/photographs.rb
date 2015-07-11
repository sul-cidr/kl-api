# == Schema Information
#
# Table name: photographs
#
#  id         :integer          not null, primary key
#  slug       :string
#  lonlat     :geometry({:srid= point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :photograph do
    slug "MyString"
lonlat ""
  end

end
