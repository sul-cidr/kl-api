# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  legacy_id     :integer
#  event_type_id :integer
#  date          :date
#  year          :integer
#  year_est      :boolean
#

class Event < ActiveRecord::Base

  has_many :participations
  has_many :people, :through => :participations

  validates :legacy_id, uniqueness: true

end
