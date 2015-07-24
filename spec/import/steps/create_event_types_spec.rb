

require 'rails_helper'

describe Import::CreateEventTypes, :import do

  it "creates distinct event types" do

    LegacyHelper.DB[:event].insert(type: "t1")
    LegacyHelper.DB[:event].insert(type: "t1")
    LegacyHelper.DB[:event].insert(type: "t2")
    LegacyHelper.DB[:event].insert(type: "t2")
    LegacyHelper.DB[:event].insert(type: "t3")
    LegacyHelper.DB[:event].insert(type: "t3")

    Import::CreateEventTypes.new.up
    expect(EventType.count).to eq(3)

    # TODO: Check type names.

  end

end
