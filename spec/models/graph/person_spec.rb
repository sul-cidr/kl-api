
require 'rails_helper'

describe Graph::Person, :neo4j, :quiet do

  describe ".index_marriages()" do

    before do
      @marriage = create(:event_type, name: "MARR")
    end

    it "creates nodes and relationships for marriages" do

      e = create(:event, type: @marriage)

      p1 = create(:person)
      p2 = create(:person)

      create(:person_event, person: p1, event: e)
      create(:person_event, person: p2, event: e)

      Graph::Person.index_marriages

      p1_node = Graph::Person.find_by(pg_id: p1.id)
      p2_node = Graph::Person.find_by(pg_id: p2.id)

      # Should create nodes.
      expect(p1_node).to_not be_nil
      expect(p2_node).to_not be_nil

      # Should create relationships.
      expect(p1_node.spouse).to eq(p2_node)

    end

    it "skips events with more than / fewer than 2 people" do

      e1 = create(:event, type: @marriage)
      e2 = create(:event, type: @marriage)

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)

      # 1 people on e1.
      create(:person_event, person: p1, event: e1)

      # 3 people on e2.
      create(:person_event, person: p1, event: e2)
      create(:person_event, person: p2, event: e2)
      create(:person_event, person: p3, event: e2)

      Graph::Person.index_marriages

      expect(Graph::Person.count).to eq(0)

    end

  end

  describe ".index_births()" do

    before do
      @birth  = create(:event_type, name: "BIRT")
      @mother = create(:role, name: "mother")
      @father = create(:role, name: "father")
      @child  = create(:role, name: "child")
    end

    it "links mother, father, and child" do

      e = create(:event, type: @birth)

      m = create(:person)
      f = create(:person)
      c = create(:person)

      create(:person_event, person: m, event: e, role: @mother)
      create(:person_event, person: f, event: e, role: @father)
      create(:person_event, person: c, event: e, role: @child)

      Graph::Person.index_births

      m_node = Graph::Person.find_by(pg_id: m.id)
      f_node = Graph::Person.find_by(pg_id: f.id)
      c_node = Graph::Person.find_by(pg_id: c.id)

      # Should create nodes.
      expect(m_node).to_not be_nil
      expect(f_node).to_not be_nil
      expect(c_node).to_not be_nil

      # Should create relationships.
      expect(m_node.child).to include c_node
      expect(f_node.child).to include c_node

    end

    it "links mother and child" do

      e = create(:event, type: @birth)

      m = create(:person)
      c = create(:person)

      create(:person_event, person: m, event: e, role: @mother)
      create(:person_event, person: c, event: e, role: @child)

      Graph::Person.index_births

      m_node = Graph::Person.find_by(pg_id: m.id)
      c_node = Graph::Person.find_by(pg_id: c.id)

      # Should create nodes.
      expect(m_node).to_not be_nil
      expect(c_node).to_not be_nil

      # Should create relationships.
      expect(m_node.child).to include c_node

    end

    it "links father and child" do

      e = create(:event, type: @birth)

      f = create(:person)
      c = create(:person)

      create(:person_event, person: f, event: e, role: @father)
      create(:person_event, person: c, event: e, role: @child)

      Graph::Person.index_births

      f_node = Graph::Person.find_by(pg_id: f.id)
      c_node = Graph::Person.find_by(pg_id: c.id)

      # Should create nodes.
      expect(f_node).to_not be_nil
      expect(c_node).to_not be_nil

      # Should create relationships.
      expect(f_node.child).to include c_node

    end

    it "skips events with no child" do

      e = create(:event, type: @birth)

      f = create(:person)
      m = create(:person)

      create(:person_event, person: f, event: e, role: @father)
      create(:person_event, person: m, event: e, role: @mother)

      Graph::Person.index_births

      expect(Graph::Person.count).to eq(0)

    end

  end

  describe ".kin()" do

    it "returns a path from source -> target" do

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)
      p4 = create(:person)
      p5 = create(:person)
      p6 = create(:person)

      n1 = Graph::Person.add_node(p1.id)
      n2 = Graph::Person.add_node(p2.id)
      n3 = Graph::Person.add_node(p3.id)
      n4 = Graph::Person.add_node(p4.id)
      n5 = Graph::Person.add_node(p5.id)
      n6 = Graph::Person.add_node(p6.id)

      # n1    n6
      # |     |
      # n2    n5
      # |     |
      # n3 -- n4

      n1.child << n2
      n2.child << n3
      n3.spouse = n4
      n5.child << n4
      n6.child << n5

      ids, rels = Graph::Person.kin(p1.id, p6.id)

      expect(ids).to eq [
        p1.id,
        p2.id,
        p3.id,
        p4.id,
        p5.id,
        p6.id,
      ]

      expect(rels).to eq [
        "child",
        "child",
        "spouse",
        "parent",
        "parent",
      ]

    end

  end

  describe ".bacon()" do

    it "returns people with N degrees" do

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)
      p4 = create(:person)
      p5 = create(:person)

      n1 = Graph::Person.add_node(p1.id)
      n2 = Graph::Person.add_node(p2.id)
      n3 = Graph::Person.add_node(p3.id)
      n4 = Graph::Person.add_node(p4.id)
      n5 = Graph::Person.add_node(p5.id)

      n1.child << n2
      n2.child << n3
      n3.child << n4
      n4.child << n5

      # 1 degree.
      expect(Graph::Person.bacon(p1.id, 1)).to eq([
        p2.id
      ])

      # 2 degrees.
      expect(Graph::Person.bacon(p1.id, 2)).to eq([
        p2.id,
        p3.id,
      ])

      # 3 degrees.
      expect(Graph::Person.bacon(p1.id, 3)).to eq([
        p2.id,
        p3.id,
        p4.id,
      ])

      # 4 degrees.
      expect(Graph::Person.bacon(p1.id, 4)).to eq([
        p2.id,
        p3.id,
        p4.id,
        p5.id,
      ])

    end

  end

end
