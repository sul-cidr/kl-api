# == Schema Information
#
# Table name: occupation_people
#
#  id            :integer          not null, primary key
#  occupation_id :integer
#  person_id     :integer
#

class OccupationPerson < ActiveRecord::Base
  belongs_to :occupations
  belongs_to :people
end
