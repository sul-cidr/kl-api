
require 'rails_helper'

describe API::RelationController, :json, type: :controller do

  describe 'GET #index', :neo4j, :quiet do

    it 'returns a path from source -> target' do

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

      get :index, source: p1.id, target: p6.id
      json = JSON.parse(response.body)

      # Pull out the Person ids.
      ids = json['people'].map {|p| p['id'] }

      expect(ids).to eq [
        p1.id,
        p2.id,
        p3.id,
        p4.id,
        p5.id,
        p6.id,
      ]

      expect(json['relationships']).to eq [
        'child',
        'child',
        'spouse',
        'parent',
        'parent',
      ]

    end

  end

end
