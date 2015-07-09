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
    it "should reject duplicate codes"
  end

end
