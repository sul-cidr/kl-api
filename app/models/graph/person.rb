
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
  # @param name [String]
  #
  def self.add_node(id, name)
    self.merge(pg_id: id, name: name)
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
          self.add_node(p.id, p.full_name)
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

      # Get the person-event link for mother/father/child.
      c = event.person_events.find{|pe| pe.role.name == "child" }
      m = event.person_events.find{|pe| pe.role.name == "mother" }
      f = event.person_events.find{|pe| pe.role.name == "father" }

      next if not c

      silence_stream(STDOUT) do

        # Get the child node.
        c_node = self.add_node(c.person.id, c.person.full_name)

        # Register mother -> child link.
        if m
          m_node = self.add_node(m.person.id, m.person.full_name)
          m_node.children << c_node
        end

        # Register father -> child link.
        if f
          f_node = self.add_node(f.person.id, f.person.full_name)
          f_node.children << c_node
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
  def self.kin_path(id1, id2)

    Neo4j::Session.query
      .match(p1: self, p2: self)
      .match("p=shortestPath((p1)-[*..100]-(p2))")
      .where(p1: { pg_id: id1 })
      .where(p2: { pg_id: id2 })
      .return("nodes(p) as nodes, relationships(p) as links")
      .to_a.first

    # TODO: Assemble path.

  end

end
