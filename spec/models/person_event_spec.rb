# == Schema Information
#
# Table name: person_events
#
#  id        :integer          not null, primary key
#  person_id :integer
#  event_id  :integer
#

require 'rails_helper'

describe PersonEvent, type: :model do

  describe "associations" do
    it { should belong_to(:person) }
    it { should belong_to(:event) }
  end

end
