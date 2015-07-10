# == Schema Information
#
# Table name: event_types
#
#  id   :integer          not null, primary key
#  type :string
#

require 'rails_helper'

describe EventType, type: :model do

  describe "validations" do
    it { should validate_uniqueness_of(:name) }
  end

end
