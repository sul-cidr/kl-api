# == Schema Information
#
# Table name: person_occupations
#
#  id            :integer          not null, primary key
#  occupation_id :integer          not null
#  person_id     :integer          not null
#

class PersonOccupation < ActiveRecord::Base
  belongs_to :person
  belongs_to :occupation
end
