# == Schema Information
#
# Table name: occupations
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Occupation, type: :model do

  describe "indexes" do
    it { should have_db_index(:name).unique(true) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { should have_many(:person_occupations) }
    it { should have_many(:people).through(:person_occupations) }
  end

end
