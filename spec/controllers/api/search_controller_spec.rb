
require 'rails_helper'

describe API::SearchController, type: :controller do

  render_views

  before(:each) do
    request.headers["Accept"] = "application/json"
  end

  describe "GET #index" do

    it "searches people, landmarks, and occupations", :solr => true do

      p1 = create(:person, given_name: "kindred")
      create(:person, given_name: "britain")

      l1 = create(:landmark, name: "kindred")
      create(:landmark, name: "britain")

      o1 = create(:occupation, name: "kindred")
      create(:occupation, name: "britain")

      Sunspot.commit

      get :index, q: "kindred"
      expect(response.body).to be_solr_records(p1, l1, o1)

    end

  end

end
