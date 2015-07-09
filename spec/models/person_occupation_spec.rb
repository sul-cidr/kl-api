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

  describe "validations" do
    it { should belong_to(:occupation) }
    it { should belong_to(:person) }
  end

end
