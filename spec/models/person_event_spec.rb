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

  describe "indexes" do
    it { should have_db_index([:person_id, :event_id]) }
    it { should have_db_index([:event_id, :person_id]) }
  end

  describe "associations" do
    it { should belong_to(:person) }
    it { should belong_to(:event) }
  end

end
