# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class EventType < ActiveRecord::Base
  has_many :events, foreign_key: "type_id"
  validates :name, presence: true, uniqueness: true
end
