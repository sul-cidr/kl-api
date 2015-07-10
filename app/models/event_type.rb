# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string
#

class EventType < ActiveRecord::Base
  has_many :events
  validates :name, uniqueness: true
end
