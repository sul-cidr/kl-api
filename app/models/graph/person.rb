
class Graph::Person

  include Neo4j::ActiveNode

  property :pg_id, type: Integer, constraint: :unique
  property :name, type: String

  validates :pg_id, :presence => true

  has_one(
    :both, :spouse,
    model_class: "Person",
    type: "spouse",
    unique: true
  )

  has_many(
    :out, :child,
    model_class: "Person",
    type: "child",
    unique: true
  )

  #
  # Register a node.
  #
  # @param id [Integer]
  #
  def self.add_node(id)
    self.merge(pg_id: id)
  end

  #
  # Index genealogical relations.
  #
  def self.index
    self.index_marriages
    self.index_births
  end

  #
  # Index marriages.
  #
  def self.index_marriages

    # Select "marriage" events.
    events = Event.joins { event_type }.where {
      event_type.name == "MARR"
    }

    bar = ProgressBar.new(events.count)

    events.each do |event|

      next if event.people.count != 2

      silence_stream(STDOUT) do

        # Insert the nodes.
        nodes = event.people.map do |p|
          self.add_node(p.id)
        end

        # Register marriage.
        nodes[0].spouse = nodes[1]

      end

      bar.increment!

    end

  end

  #
  # Index births.
  #
  def self.index_births

    # Select "birth" events.
    events = Event.joins { event_type }.where {
      event_type.name == "BIRT"
    }

    bar = ProgressBar.new(events.count)

    events.each do |event|

      m, f, c = nil
      event.person_event_rels.each do |pe|
        m = pe.person if pe.event_role.name == "mother"
        f = pe.person if pe.event_role.name == "father"
        c = pe.person if pe.event_role.name == "child"
      end

      next if not c

      silence_stream(STDOUT) do

        c_node = self.add_node(c.id)

        # Register mother -> child link.
        if m
          m_node = self.add_node(m.id)
          m_node.child << c_node
        end

        # Register father -> child link.
        if f
          f_node = self.add_node(f.id)
          f_node.child << c_node
        end

      end

      bar.increment!

    end

  end

  #
  # Given two Person ids, get the genealogical shortest-path.
  #
  # @param id1 [Integer]
  # @param id2 [Integer]
  #
  def self.kin(id1, id2)

    r = Neo4j::Session.query
      .match(p1: self, p2: self)
      .match("p=shortestPath((p1)-[*..100]-(p2))")
      .where(p1: { pg_id: id1 })
      .where(p2: { pg_id: id2 })
      .return("nodes(p) as people, relationships(p) as rels")
      .to_a.first

    # Postgres ids.
    pg_ids = r.people.map(&:pg_id)

    # Neo4j ids.
    n4_ids = r.people.map(&:neo_id)

    # Relationship Neo4j ids.
    rel_ids = r.rels.map do |rel|
      [rel.start_node_neo_id, rel.end_node_neo_id]
    end

    # Walk the path ids in pairs.
    rels = n4_ids
      .each_cons(2)
      .map
      .with_index do |(nid1, nid2), i|

      # Get the relationship type.
      type = r.rels[i].rel_type.to_s

      # If the relation order matches the path order, or the type is spouse
      # (undirected), use the vanilla type name.
      if rel_ids[i] == [nid1, nid2] or type == "spouse"
        type

      # Otherwise, the path pair is A -> B, but the relation is B -child-> A,
      # and we need to flip "child" to "parent".
      else
        "parent"
      end

    end

    return pg_ids, rels

  end

  #
  # Given a Person id, find all people with N steps.
  #
  # @param id [Integer]
  # @param steps [Integer]
  #
  def self.bacon(id, steps)

    r = Neo4j::Session.query
      .match(s: self)
      .match("(s)-[*..#{steps}]-(t)")
      .where(s: { pg_id: id })
      .return("t as person")

    r.to_a.map(&:person).map do |p|
      p.pg_id
    end

  end

end
