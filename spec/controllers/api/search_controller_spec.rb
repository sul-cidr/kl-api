
require 'rails_helper'

describe API::SearchController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "returns results for people, landmarks, and occupations" do
      get :index, q: "kindred"
    end

  end

end
