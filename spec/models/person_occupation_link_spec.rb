# == Schema Information
#
# Table name: person_occupation_links
#
#  id            :integer          not null, primary key
#  occupation_id :integer          not null
#  person_id     :integer          not null
#

require 'rails_helper'

describe PersonOccupationLink, type: :model do

  describe "columns" do
    it { should have_db_column(:occupation_id).with_options(null: false) }
    it { should have_db_column(:person_id).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index([:occupation_id, :person_id]) }
    it { should have_db_index([:person_id, :occupation_id]) }
  end

  describe "associations" do
    it { should belong_to(:occupation) }
    it { should belong_to(:person) }
  end

end
