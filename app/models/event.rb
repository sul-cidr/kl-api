# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  person_id  :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base
end
