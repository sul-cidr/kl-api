# == Schema Information
#
# Table name: participations
#
#  id        :integer          not null, primary key
#  person_id :integer
#  event_id  :integer
#

class Participation < ActiveRecord::Base
  belongs_to :people
  belongs_to :events
end
