# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Occupation, type: :model do

  describe "validations" do

    it "should reject duplicate names" do
      Occupation.create(name: "o1")
      expect(Occupation.new(name: "o1")).not_to be_valid
      expect(Occupation.new(name: "o2")).to be_valid
    end

  end

end
