# == Schema Information
#
# Table name: person_events
#
#  id        :integer          not null, primary key
#  person_id :integer
#  event_id  :integer
#

class PersonEvent < ActiveRecord::Base
  belongs_to :people
  belongs_to :events
end
