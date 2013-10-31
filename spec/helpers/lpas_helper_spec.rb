require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the LpasHelper. For example:
#
# describe LpasHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe LpasHelper do
  describe "attorneys_overview" do
    it "should return correctly for 1 attorney" do
      lpa = Lpa.new(:attorneys => [Attorney.new({:first_name => "John", :last_name => "Barbs", :title => "Mr"})])
      helper.attorneys_overview(lpa).should == "The attorney is Mr John Barbs"
    end

    it "should return correctly for 2 attorneys" do
      lpa = Lpa.new(:attorneys => [
        Attorney.new({:first_name => "John", :last_name => "Barbs", :title => "Mr"}),
        Attorney.new({:first_name => "Joanna", :last_name => "Barbs", :title => "Mrs"})
      ])
      helper.attorneys_overview(lpa).should == "The attorneys are Mr John Barbs and Mrs Joanna Barbs"
    end

    it "should return correctly for 3 attorneys" do
      lpa = Lpa.new(:attorneys => [
        Attorney.new({:first_name => "John", :last_name => "Barbs", :title => "Mr"}),
        Attorney.new({:first_name => "Joanna", :last_name => "Barbs", :title => "Mrs"}),
        Attorney.new({:first_name => "Bob", :last_name => "Barbs", :title => "Miss"})
      ])
      helper.attorneys_overview(lpa).should == "The attorneys are Mr John Barbs, Mrs Joanna Barbs and Miss Bob Barbs"
    end
  end

  describe "replacement_attorneys_overview" do
    it "should return correctly for 1 attorney" do
      lpa = Lpa.new(:replacement_attorneys => [Attorney.new({:first_name => "John", :last_name => "Barbs", :title => "Mr"})])
      helper.replacement_attorneys_overview(lpa).should == "The replacement attorney is Mr John Barbs"
    end

    it "should return correctly for 2 attorneys" do
      lpa = Lpa.new(:replacement_attorneys => [
        Attorney.new({:first_name => "John", :last_name => "Barbs", :title => "Mr"}),
        Attorney.new({:first_name => "Joanna", :last_name => "Barbs", :title => "Mrs"})
      ])
      helper.replacement_attorneys_overview(lpa).should == "The replacement attorneys are Mr John Barbs and Mrs Joanna Barbs"
    end

    it "should return correctly for 3 attorneys" do
      lpa = Lpa.new(:replacement_attorneys => [
        Attorney.new({:first_name => "John", :last_name => "Barbs", :title => "Mr"}),
        Attorney.new({:first_name => "Joanna", :last_name => "Barbs", :title => "Mrs"}),
        Attorney.new({:first_name => "Bob", :last_name => "Barbs", :title => "Miss"})
      ])
      helper.replacement_attorneys_overview(lpa).should == "The replacement attorneys are Mr John Barbs, Mrs Joanna Barbs and Miss Bob Barbs"
    end
  end
end
