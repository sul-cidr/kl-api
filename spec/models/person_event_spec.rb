# == Schema Information
#
# Table name: person_events
#
#  id            :integer          not null, primary key
#  person_id     :integer          not null
#  event_id      :integer          not null
#  event_role_id :integer          not null
#

require 'rails_helper'

describe PersonEvent, type: :model do

  describe "columns" do
    it { should have_db_column(:person_id).with_options(null: false) }
    it { should have_db_column(:event_id).with_options(null: false) }
    it { should have_db_column(:event_role_id).with_options(null: false) }
  end

  describe "indexes" do
    it { should have_db_index([:person_id, :event_id]) }
    it { should have_db_index([:event_id, :person_id]) }
  end

  describe "associations" do
    it { should belong_to(:person) }
    it { should belong_to(:event) }
    it { should belong_to(:event_role) }
  end

end
