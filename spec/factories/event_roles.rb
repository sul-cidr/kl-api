# == Schema Information
#
# Table name: event_roles
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do

  sequence :event_role_name do |n|
    "role#{n}"
  end

  factory :event_role do
    name { generate(:event_role_name) }
  end

end
