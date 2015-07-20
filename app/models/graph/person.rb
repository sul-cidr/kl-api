
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
      event.person_events.each do |pe|
        m = pe.person if pe.role.name == "mother"
        f = pe.person if pe.role.name == "father"
        c = pe.person if pe.role.name == "child"
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

    neo_ids = r.people.map do |p|
      p.neo_id
    end

    pg_ids = r.people.map do |p|
      p.pg_id
    end

    rel_ids = r.rels.map do |rel|
      [rel.start_node_neo_id, rel.end_node_neo_id]
    end

    links = neo_ids.each_cons(2).to_a.each_with_index.map do |(nid1, nid2), i|

      type = r.rels[i].rel_type.to_s

      if rel_ids[i] == [nid1, nid2] || type == "spouse"
        type
      else
        "parent"
      end

    end

    return pg_ids, links

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
