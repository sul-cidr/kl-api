# == Schema Information
#
# Table name: roles
#
#  id   :integer          not null, primary key
#  name :string           not null
#


require 'rails_helper'

describe EventRole, type: :model do

  describe "columns" do
    it { should have_db_column(:name).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index(:name).unique(true) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

end
