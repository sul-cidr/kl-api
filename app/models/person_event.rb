# == Schema Information
#
# Table name: person_events
#
#  id        :integer          not null, primary key
#  person_id :integer          not null
#  event_id  :integer          not null
#  role_id   :integer          not null
#

class PersonEvent < ActiveRecord::Base
  belongs_to :person
  belongs_to :event
  belongs_to :event_role
end
