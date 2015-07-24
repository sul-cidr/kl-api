# == Schema Information
#
# Table name: person_occupation_links
#
#  id            :integer          not null, primary key
#  occupation_id :integer          not null
#  person_id     :integer          not null
#

class PersonOccupationLink < ActiveRecord::Base
  belongs_to :occupation
  belongs_to :person
end
