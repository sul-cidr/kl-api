# == Schema Information
#
# Table name: landmark_to_people
#
#  id          :integer          not null, primary key
#  landmark_id :integer
#  person_id   :integer
#

require 'rails_helper'

describe LandmarkToPerson, type: :model do

  describe "columns" do
    it { should have_db_column(:landmark_id).with_options(null: false) }
    it { should have_db_column(:person_id).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index([:landmark_id, :person_id]) }
    it { should have_db_index([:person_id, :landmark_id]) }
  end

  describe "associations" do
    it { should belong_to(:landmark) }
    it { should belong_to(:person) }
  end

end
