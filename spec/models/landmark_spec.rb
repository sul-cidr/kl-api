# == Schema Information
#
# Table name: landmarks
#
#  id               :integer          not null, primary key
#  name             :string
#  landmark_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  lonlat           :geometry({:srid= point, 0
#

require 'rails_helper'

describe Landmark, type: :model do

  describe "indexes" do
    it { should have_db_index(:lonlat) }
  end

  describe "associations" do
    it { should belong_to(:landmark_type) }
  end

  describe "solr" do
    it { should have_searchable_field(:name) }
  end

  describe ".in_extent()" do

    it "returns landmarks inside of the passed polygon" do

      lm1 = create(:landmark, lonlat: GeoHelper.point(1, 1))
      lm2 = create(:landmark, lonlat: GeoHelper.point(1, 2))
      create(:landmark, lonlat: GeoHelper.point(1, 4))
      create(:landmark, lonlat: GeoHelper.point(1, 5))

      extent = GeoHelper.polygon(
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

      lm1 = create(:landmark, lonlat: GeoHelper.point(1, 0))
      lm2 = create(:landmark, lonlat: GeoHelper.point(2, 0))
      create(:landmark, lonlat: GeoHelper.point(4, 0))
      create(:landmark, lonlat: GeoHelper.point(5, 0))

      landmarks = Landmark.in_radius(0, 0, 3)
      expect(landmarks).to be_records(lm1, lm2)

    end

  end

  describe ".by_types()" do

    it "returns landmarks of 1+ types" do

      t1 = create(:landmark_type_with_landmarks)
      t2 = create(:landmark_type_with_landmarks)
      create(:landmark_type_with_landmarks)

      landmarks = Landmark.by_types(t1.id, t2.id)
      expect(landmarks).to be_records(*t1.landmarks+t2.landmarks)

    end

  end

end
