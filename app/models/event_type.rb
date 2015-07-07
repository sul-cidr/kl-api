# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  code :string
#

class EventType < ActiveRecord::Base
  validates :code, uniqueness: true
end
