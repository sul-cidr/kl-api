
require 'rails_helper'
require 'spec_helper'

describe V1::PeopleController, type: :controller do

  render_views

  let(:per_page) { 25 }

  let(:fields) { ["id", "family_name", "given_name"] }

  before(:each) do
    request.headers["Accept"] = "application/json; version=1"
  end

  describe "GET #index" do

    before(:each) do
      @people = create_list(:person, 100)
    end

    it "should provide a list of people (with default pagination)" do

      get :index
      json = JSON.parse(response.body)

      # 25 records by default.
      expect(json.length).to eq(per_page)

      # Should provide the first 25 records.
      @people[0...per_page].each_with_index do |person, i|
        fields.each do |field|
          expect(json[i][field]).to eq(person[field])
        end
      end

    end

  end

end
