# == Schema Information
#
# Table name: landmarks
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lonlat             :geometry({:srid= point, 0
#  start_year         :integer
#  opened             :integer
#  opened_qualifier   :string
#  closed             :integer
#  closed_qualifier   :string
#  location_qualifier :string
#  address_name       :string
#  address_street     :string
#  address_type       :string
#  address_postal     :string
#  priority           :integer
#  kb_association     :string
#  also_known_as      :string
#  category           :string
#  notes              :string
#  architect          :string
#  artist             :string
#  denomination       :string
#  monument_type      :string
#  physical_type      :string
#  monument_subject   :string
#  monument_sphere_1  :string
#  monument_sphere_2  :string
#  monument_sphere_3  :string
#  monument_patronage :string
#  monument_legend    :string
#  person_dates       :string
#  research_questions :string
#  branch             :string
#  kb_tag             :string
#  kb_subtag          :string
#  kb_extra_tag       :string
#  court_type         :string
#  railway_line       :string
#  drama_category     :string
#

require 'rails_helper'

describe Landmark, type: :model do

  describe "indexes" do
    it { should have_db_index(:lonlat) }
  end

  describe "solr" do
    it { should have_searchable_field(:name) }
  end

  describe ".in_extent()" do

    it "returns landmarks inside of the passed polygon" do

      lm1 = create(:landmark, lonlat: Helpers::Geo.point(1, 1))
      lm2 = create(:landmark, lonlat: Helpers::Geo.point(1, 2))
      create(:landmark, lonlat: Helpers::Geo.point(1, 4))
      create(:landmark, lonlat: Helpers::Geo.point(1, 5))

      extent = Helpers::Geo.polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      landmarks = Landmark.in_extent(extent.to_s)
      expect(landmarks).to be_records(lm1, lm2)

    end

  end

  describe ".in_radius()" do

    it "returns landmarks with a given radius of a point" do

      lm1 = create(:landmark, lonlat: Helpers::Geo.point(1, 0))
      lm2 = create(:landmark, lonlat: Helpers::Geo.point(2, 0))
      create(:landmark, lonlat: Helpers::Geo.point(4, 0))
      create(:landmark, lonlat: Helpers::Geo.point(5, 0))

      landmarks = Landmark.in_radius(0, 0, 3)
      expect(landmarks).to be_records(lm1, lm2)

    end

  end

end
