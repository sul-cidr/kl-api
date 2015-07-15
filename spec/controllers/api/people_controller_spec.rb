
require 'rails_helper'

describe API::PeopleController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do
  end

end
