# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class EventType < ActiveRecord::Base
  has_many :events
  validates :name, presence: true, uniqueness: true
end
