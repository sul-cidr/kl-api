# == Schema Information
#
# Table name: person_event_links
#
#  id            :integer          not null, primary key
#  person_id     :integer          not null
#  event_id      :integer          not null
#  event_role_id :integer          not null
#

FactoryGirl.define do

  factory :person_event_link do
    person
    event
    event_role
  end

end
