
require 'rails_helper'

describe API::BaconController, type: :controller do

  render_views

  before(:each) do
    request.headers['Accept'] = 'application/json'
  end

  describe 'GET #index', :neo4j, :quiet do

    it 'returns ids for people within N steps' do

      p1 = create(:person)
      p2 = create(:person)
      p3 = create(:person)
      p4 = create(:person)
      p5 = create(:person)

      n1 = Graph::Person.add_node(p1.id)
      n2 = Graph::Person.add_node(p2.id)
      n3 = Graph::Person.add_node(p3.id)
      n4 = Graph::Person.add_node(p4.id)
      n5 = Graph::Person.add_node(p5.id)

      n1.child << n2
      n2.child << n3
      n3.child << n4
      n4.child << n5

      get :index, source: p1.id, steps: 3
      json = JSON.parse(response.body)

      expect(json['people']).to eq [
        p2.id,
        p3.id,
        p4.id,
      ]

    end

  end

end
