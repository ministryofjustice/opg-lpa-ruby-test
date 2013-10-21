require 'spec_helper'

describe Lpa do
	before :each do
		@lpa = Lpa.new
	end
  describe "update" do
  	it "should return true if response is 201" do
  		stub_request(:put, Lpa::Host).to_return(:status => 201)
  		@lpa.update({}).should be_true
  	end

  	it "should return false if response if not 201" do
  		stub_request(:put, Lpa::Host).to_return(:status => 400)
  		@lpa.update({}).should be_false
  	end
  end
end
