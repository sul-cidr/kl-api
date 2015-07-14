# == Schema Information
#
# Table name: photographs
#
#  id         :integer          not null, primary key
#  slug       :string           not null
#  lonlat     :geometry({:srid= point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Photograph, type: :model do

  describe "indexes" do
    it { should have_db_index(:slug).unique(true) }
  end

  describe "validations" do
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
  end

end
