# == Schema Information
#
# Table name: landmarks
#
#  id               :integer          not null, primary key
#  name             :string
#  landmark_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  lonlat           :geometry({:srid= point, 0
#

FactoryGirl.define do
  factory :landmark do
    
  end

end