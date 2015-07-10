# == Schema Information
#
# Table name: landmark_types
#
#  id   :integer          not null, primary key
#  name :string
#

require 'rails_helper'

describe LandmarkType, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of(:name) }
  end

end
