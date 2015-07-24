# == Schema Information
#
# Table name: people
#
#  id          :integer          not null, primary key
#  family_name :string
#  given_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sex         :string
#  birth_year  :integer
#  death_year  :integer
#  legacy_id   :string
#  birth_est   :boolean
#  death_est   :boolean
#

require "rails_helper"

describe Person, :type => :model do

  describe "indexes" do
    it { should have_db_index(:legacy_id).unique(true) }
  end

  describe "validations" do
    it { should validate_uniqueness_of(:legacy_id) }
  end

  describe "associations" do
    it { should have_many(:person_event_rels) }
    it { should have_many(:events).through(:person_event_rels) }
    it { should have_many(:person_occupation_rels) }
    it { should have_many(:occupations).through(:person_occupation_rels) }
  end

  describe "solr" do
    it { should have_searchable_field(:name) }
  end

  describe "#full_name()" do

    it "combines the given and family names" do

      person = build(:person, {
        given_name: "David",
        family_name: "McClure"
      })

      expect(person.full_name).to eq("David McClure")

    end

  end

end
