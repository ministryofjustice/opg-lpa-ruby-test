require 'spec_helper'

describe Lpa do
	before :each do
		@json = {
			:title => "Mr",
			:attorneys => [
				{:title => "Mrs"}
			],
			:donor => {:address => {:post_code => "E2 6BH"}}
		}
		@lpa = Lpa.new(@json)
	end

	describe "from json" do
		it "should assign it's own attributes" do
			@lpa.title.should == "Mr"
		end

		it "should create child attorneys from the json" do
			@lpa.attorneys.size.should == 1
			@lpa.attorneys.first.should be_a Attorney
		end

		it "should set attributes on the child attorneys" do
			@lpa.attorneys.first.title.should == "Mrs"
		end

		it "should be able to assign a donor" do
			@lpa.donor.title = "Mr"
			@lpa.donor.title.should == "Mr"
		end
	end

  describe "create" do
  	it "should post the full json" do
  		stub_request(:post, "http://localhost:9292/api/lpas.json")
  		@lpa.save
			a_request(:post, "http://localhost:9292/api/lpas.json").with(:body => '{"donor":{"address":{"post_code":"E2 6BH"}},"attorneys":[{"address":{},"title":"Mrs"}],"title":"Mr"}').should have_been_made
  	end
  end

  describe "associations" do
  	it "should not make an api call when requesting nil donor" do
  		Lpa.new.donor
  	end
  	it "should not make an api call when requesting nil attorneys" do
  		Lpa.new.attorneys
  	end
  end

  describe "validation errors" do
  	it "should set errors on the child objects" do
  		stub_request(:post, "http://localhost:9292/api/lpas.json").to_return(:status => 422, :body => {"errors"=>{"donor"=> {"last_name"=>["can't be blank", "is too short (minimum is 2 characters)"]}}}.to_json)
  		@lpa.save
  		@lpa.errors.raw_hash[:donor][:last_name].should == ["can't be blank", "is too short (minimum is 2 characters)"]
  	end
  end
end
