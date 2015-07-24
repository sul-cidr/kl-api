# == Schema Information
#
# Table name: person_event_links
#
#  id            :integer          not null, primary key
#  person_id     :integer          not null
#  event_id      :integer          not null
#  event_role_id :integer          not null
#

class PersonEventLink < ActiveRecord::Base
  belongs_to :person
  belongs_to :event
  belongs_to :event_role
end
