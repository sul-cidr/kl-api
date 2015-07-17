
class Graph::Person

  include Neo4j::ActiveNode

  property :pg_id, type: Integer, constraint: :unique
  validates :pg_id, :presence => true

  has_one(
    :both, :spouse,
    model_class: "Person",
    type: "spouse",
    unique: true
  )

  has_many(
    :out, :children,
    model_class: "Person",
    type: "children",
    unique: true
  )

  #
  # Index genealogical relationships.
  #
  def self.index
    self.delete_all
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
          self.merge(pg_id: p.id)
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

      next if event.person_events.count != 3

      # Get person-event links for mother/father/child.
      m = event.person_events.find{|pe| pe.role.name == "mother" }
      f = event.person_events.find{|pe| pe.role.name == "father" }
      c = event.person_events.find{|pe| pe.role.name == "child" }

      silence_stream(STDOUT) do

        # Get nodes for the participants.
        m_node = self.find_by(pg_id: m.person.id)
        f_node = self.find_by(pg_id: f.person.id)
        c_node = self.find_by(pg_id: c.person.id)

        # Register the links.
        m_node.children << c_node
        f_node.children << c_node

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
      .return("nodes(p) as nodes, relationships(p) as rels")
      .to_a

  end

end
