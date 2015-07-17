# == Schema Information
#
# Table name: people
#
#  id          :integer          not null, primary key
#  family_name :string
#  given_name  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  sex         :string
#  birth_year  :integer
#  death_year  :integer
#  legacy_id   :string
#  birth_est   :boolean
#  death_est   :boolean
#

class Person < ActiveRecord::Base

  has_many :person_events
  has_many :events, :through => :person_events

  has_many :person_occupations
  has_many :occupations, :through => :person_occupations

  validates :legacy_id, uniqueness: true

  searchable do

    text :name, :stored => true do
      full_name
    end

    boost { events.count+1 }

  end

  #
  # Index kin relationships in Neo4j.
  #
  def self.index

    # Select "birth" and "marriage" events.
    kin_events = Event.joins { event_type }.where {
      event_type.name >> ["BIRT", "MARR"]
    }

    kin_events.each do |e|

      # Insert the nodes.
      nodes = e.people.map do |p|
        PersonNode.merge(pg_id: p.id)
      end

      # Index undirected edges.
      nodes.combination(2).each do |pair|
        pair[0].kin << pair[1]
      end

    end

  end

  #
  # Assemble a full name from the given and family names.
  #
  # returns [String]
  #
  def full_name
    "#{given_name} #{family_name}"
  end

end


class PersonNode

  include Neo4j::ActiveNode

  property :pg_id, type: Integer, constraint: :unique
  validates :pg_id, :presence => true

  has_many(
    :both, :kin,
    model_class: "PersonNode",
    type: "kin",
    unique: true
  )

end
