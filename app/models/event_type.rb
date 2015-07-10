# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  type :string
#

class EventType < ActiveRecord::Base
  validates :name, uniqueness: true
end
