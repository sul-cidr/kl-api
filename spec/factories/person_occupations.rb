# == Schema Information
#
# Table name: person_occupations
#
#  id            :integer          not null, primary key
#  occupation_id :integer          not null
#  person_id     :integer          not null
#

FactoryGirl.define do

  factory :occupation_person do
    # TODO
  end

end
