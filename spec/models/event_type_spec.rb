# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  name :string           not null
#

require 'rails_helper'

describe EventType, type: :model do

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "associations" do
    it { should have_many(:events) }
  end

end
