# == Schema Information
#
# Table name: person_occupations
#
#  id            :integer          not null, primary key
#  occupation_id :integer
#  person_id     :integer
#

require 'rails_helper'

describe PersonOccupation, type: :model do

  describe "indexes" do
    it { should have_db_index([:occupation_id, :person_id]) }
    it { should have_db_index([:person_id, :occupation_id]) }
  end

  describe "associations" do
    it { should belong_to(:occupation) }
    it { should belong_to(:person) }
  end

end
