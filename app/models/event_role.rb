# == Schema Information
#
# Table name: event_roles
#
#  id   :integer          not null, primary key
#  name :string           not null
#

class EventRole < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end
