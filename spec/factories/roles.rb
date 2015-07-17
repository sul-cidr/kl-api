# == Schema Information
#
# Table name: roles
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do

  sequence :role_name do |n|
    "role#{n}"
  end

  factory :role do
    name { generate(:role_name) }
  end

end
