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

  describe "associations" do
    it { should belong_to(:landmark_type) }
  end

end
