# == Schema Information
#
# Table name: landmarks
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lonlat     :geometry({:srid= point, 0
#  start_year :integer
#

FactoryGirl.define do

  factory :landmark do
    name "Landmark Name"
  end

end
