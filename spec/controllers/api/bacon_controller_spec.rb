
require 'rails_helper'

describe API::BaconController, type: :controller do

  render_views

  before(:each) do
    request.headers['Accept'] = 'application/json'
  end

  describe 'GET #index', :neo4j, :quiet do

    it 'returns ids within N steps'

  end

end
