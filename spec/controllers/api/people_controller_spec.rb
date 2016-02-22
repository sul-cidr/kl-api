
require 'rails_helper'

describe API::PeopleController, :json, type: :controller do

  describe 'GET #show' do

    it 'returns the requested person' do

      p = create(:person)

      get :show, id: p.id
      json = JSON.parse(response.body)

      expect(json['person']['id']).to eq(p.id)

    end

  end

end
