# == Schema Information
#
# Table name: photographs
#
#  id              :integer          not null, primary key
#  lonlat          :geometry({:srid= point, 0
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  flickr_id       :integer          not null
#  flickr_url      :string           not null
#  title           :string
#  address         :string
#  license         :integer
#  permission      :boolean
#  fee             :string
#  credit          :string
#  accuracy        :integer
#  permission_date :date
#  place           :string
#  legacy_id       :string
#  notes           :text
#  image_url       :string
#  fsize_url       :string
#  thumb_url       :string
#  exists          :boolean
#

require 'rails_helper'

describe Photograph, type: :model do

  describe "columns" do
    it { should have_db_column(:flickr_id).with_options(null: false) }
    it { should have_db_column(:flickr_url).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index(:flickr_id).unique(true) }
    it { should have_db_index(:lonlat) }
  end

  describe "validations" do
    subject { create(:photograph) }
    it { should validate_presence_of(:flickr_id) }
    it { should validate_uniqueness_of(:flickr_id) }
    it { should validate_presence_of(:flickr_url) }
  end

  describe ".in_extent()" do

    it "returns photographs inside of the passed polygon" do

      p1 = create(:photograph, lonlat: Helpers::Geo.point(1, 1))
      p2 = create(:photograph, lonlat: Helpers::Geo.point(1, 2))
      create(:photograph, lonlat: Helpers::Geo.point(1, 4))
      create(:photograph, lonlat: Helpers::Geo.point(1, 5))

      extent = Helpers::Geo.polygon(
        [0, 0],
        [0, 3],
        [2, 3],
        [2, 0],
      )

      photos = Photograph.in_extent(extent.to_s)
      expect(photos).to be_records(p1, p2)

    end

  end

  describe ".in_radius()" do

    it "returns photographs with a given radius of a point" do

      p1 = create(:photograph, lonlat: Helpers::Geo.point(1, 0))
      p2 = create(:photograph, lonlat: Helpers::Geo.point(2, 0))
      create(:photograph, lonlat: Helpers::Geo.point(4, 0))
      create(:photograph, lonlat: Helpers::Geo.point(5, 0))

      photos = Photograph.in_radius(0, 0, 3)
      expect(photos).to be_records(p1, p2)

    end

  end

end
