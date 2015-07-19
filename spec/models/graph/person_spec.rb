
require 'rails_helper'

describe Graph::Person, :neo4j, :quiet do

  after do
    puts Graph::Person.count
  end

  describe ".index_marriages()" do

    it "creates nodes and relationships for marriages" do

      marriage = create(:event_type, name: "MARR")

      e1 = create(:event, event_type: marriage)
      e2 = create(:event, event_type: marriage)

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)
      p4 = create(:person)
      p5 = create(:person)
      p6 = create(:person)

      create(:person_event, person: p1, event: e1)
      create(:person_event, person: p2, event: e1)
      create(:person_event, person: p3, event: e2)
      create(:person_event, person: p4, event: e2)

      Graph::Person.index_marriages

      p1_node = Graph::Person.find_by(pg_id: p1.id)
      p2_node = Graph::Person.find_by(pg_id: p2.id)
      p3_node = Graph::Person.find_by(pg_id: p3.id)
      p4_node = Graph::Person.find_by(pg_id: p4.id)
      p5_node = Graph::Person.find_by(pg_id: p5.id)
      p6_node = Graph::Person.find_by(pg_id: p6.id)

      # Should create nodes.
      expect(p1_node).to_not be_nil
      expect(p2_node).to_not be_nil
      expect(p3_node).to_not be_nil
      expect(p4_node).to_not be_nil
      expect(p5_node).to be_nil
      expect(p6_node).to be_nil

      # Should create relationships.
      expect(p1_node.spouse).to eq(p2_node)
      expect(p1_node.spouse).to eq(p2_node)

    end

  end

end
