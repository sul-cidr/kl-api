
class Graph::Person

  include Neo4j::ActiveNode

  property :pg_id, type: Integer, constraint: :unique
  validates :pg_id, :presence => true

  has_many(
    :both, :kin,
    model_class: "Person",
    type: "kin",
    unique: true
  )

  #
  # Index birth and marriage relationships.
  #
  def self.index!

    # Select "birth" and "marriage" events.
    events = Event.joins { event_type }.where {
      event_type.name >> ["BIRT", "MARR"]
    }

    bar = ProgressBar.new(events.count)

    events.each do |e|

      silence_stream(STDOUT) do

        # Insert the nodes.
        e.people.map do |p|
          self.merge(pg_id: p.id)
        end

      end

      # TODO: Register relationships.

      bar.increment!

    end

  end

end
