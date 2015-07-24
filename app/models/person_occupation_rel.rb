# == Schema Information
#
# Table name: person_occupation_rels
#
#  id            :integer          not null, primary key
#  occupation_id :integer          not null
#  person_id     :integer          not null
#

class PersonOccupationRel < ActiveRecord::Base
  belongs_to :person
  belongs_to :occupation
end
