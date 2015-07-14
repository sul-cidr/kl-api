# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do

  sequence :occupation_name do |n|
    "Occupation #{n}"
  end

  factory :occupation do
    name { generate(:occupation_name) }
  end

end
