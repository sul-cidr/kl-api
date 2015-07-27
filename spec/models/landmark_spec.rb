# == Schema Information
#
# Table name: landmarks
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lonlat        :geometry({:srid= point, 0
#  unveiled_year :integer
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
