
require 'rails_helper'

describe API::SearchController, :json, type: :controller do

  describe "GET #index", :solr do

    it "searches people, landmarks, and occupations" do

      p1 = create(:person, given_name: "dog")
      p2 = create(:person, given_name: "dog cat")
      create(:person, given_name: "cat")

      l1 = create(:landmark, name: "dog")
      l2 = create(:landmark, name: "dog cat")
      create(:landmark, name: "cat")

      o1 = create(:occupation, name: "dog")
      o2 = create(:occupation, name: "dog cat")
      create(:occupation, name: "cat")

      Sunspot.commit

      get :index, query: "dog"

      json = JSON.parse(response.body)

      expect(json["people"]).to be_solr_records(p1, p2)
      expect(json["landmarks"]).to be_solr_records(l1, l2)
      expect(json["occupations"]).to be_solr_records(o1, o2)

    end

  end

end
