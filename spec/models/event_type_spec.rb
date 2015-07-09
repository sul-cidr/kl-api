# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  code :string
#

require 'rails_helper'

describe EventType, type: :model do

  describe "validations" do

    it "should reject duplicate codes" do
      EventType.create(code: "CODE1")
      expect(EventType.new(code: "CODE1")).to_not be_valid
      expect(EventType.new(code: "CODE2")).to be_valid
    end

  end

end
