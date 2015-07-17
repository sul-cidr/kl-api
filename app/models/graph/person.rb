
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

end
