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
    it { should have_many(:person_events) }
    it { should have_many(:events).through(:person_events) }
    it { should have_many(:person_occupations) }
    it { should have_many(:occupations).through(:person_occupations) }
    it { should validate_uniqueness_of(:legacy_id) }
  end

end
