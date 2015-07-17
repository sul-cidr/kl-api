
class Neo4j

  #
  # Spin up a Neography connection.
  #
  def initialize
    @neo = Neography::Rest.new
  end

  #
  # Index birth and marriage relationships.
  #
  def index_kin!

    # Select "birth" and "marriage" events.
    events = Event.joins { event_type }.where {
      event_type.name >> ["BIRT", "MARR"]
    }

    bar = ProgressBar.new(events.count)

    events.each do |e|

      # Insert the nodes.
      e.people.map do |p|
        @neo.create_node(pg_id: p.id)
      end

      # TODO: Register relationships.

      bar.increment!

    end

  end

  #
  # Clear all node and relationships.
  #
  def reset!
    # TODO
  end

end
