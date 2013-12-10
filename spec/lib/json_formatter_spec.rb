require 'spec_helper'

describe JSONFormatter do

  context "when only a donor is present" do
    let(:json) { donor_json }

    it "should only have data for donor" do
      JSONFormatter.new(json).to_form_data.should eq good_hash
    end
  end

end
