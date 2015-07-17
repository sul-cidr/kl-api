
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

end
