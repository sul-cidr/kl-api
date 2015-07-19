
require 'rails_helper'

describe Graph::Person do

  describe ".index_marriages()" do

    it "creates nodes and relationships for marriages" do

      # create two events of type marriage
      # create 4 people, link to the events
      # index_marriages
      # check for the nodes

      marriage = create(:event_type, name: "MARR")

      e1 = create(:event, event_type: marriage)
      e2 = create(:event, event_type: marriage)

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)
      p4 = create(:person)

      create(:person_event, person: p1, event: e1)
      create(:person_event, person: p2, event: e1)
      create(:person_event, person: p3, event: e2)
      create(:person_event, person: p4, event: e2)

      Graph::Person.index_marriages

    end

  end

end
