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

  describe "validations" do

    it "should reject duplicate legacy_ids" do
      Person.create(legacy_id: 1)
      expect(Person.new(legacy_id: 1)).not_to be_valid
      expect(Person.new(legacy_id: 2)).to be_valid
    end

  end

end
