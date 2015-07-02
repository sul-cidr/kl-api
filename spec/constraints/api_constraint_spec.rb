
require "spec_helper"
require "constraints/api_constraint"

describe ApiConstraint do

  let(:request) {
    double :request
  }

  describe "#matches?" do

    let(:version) { 1 }

    subject(:constraint) {
      described_class.new(version: version)
    }

    def header(version)
      "version=#{version}"
    end

    it "matches the requested version" do
      request.stub(headers: { accept: header(version) })
      expect(constraint.matches?(request)).to be_true
    end

  end

end
