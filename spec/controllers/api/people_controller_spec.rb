
require 'rails_helper'

describe API::PhotographsController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do
  end

end
