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

  describe "how_attorneys_act_overview" do
    it "should display jointly accurately" do
      lpa = Lpa.new(:how_attorneys_act => "Jointly")
      helper.how_attorneys_act_overview(lpa).should == "The attorneys will act jointly"
    end
    it "should display jointly and seperately accurately" do
      lpa = Lpa.new(:how_attorneys_act => "Jointly and Severally")
      helper.how_attorneys_act_overview(lpa).should == "The attorneys will act jointly and severally"
    end
    it "should display some jointly, some sepreately accurately" do
      lpa = Lpa.new(:how_attorneys_act => "Jointly for some decisions, and jointly and severally for other decisions")
      helper.how_attorneys_act_overview(lpa).should == "The attorneys will act jointly for some decisions, and jointly and severally for other decisions"
    end
  end

  describe "how_replacement_attorneys_act_overview" do
    it "should display jointly accurately" do
      lpa = Lpa.new(:how_replacement_attorneys_act => "Jointly")
      helper.how_replacement_attorneys_act_overview(lpa).should == "The replacement attorneys will act jointly"
    end
    it "should display jointly and seperately accurately" do
      lpa = Lpa.new(:how_replacement_attorneys_act => "Jointly and Severally")
      helper.how_replacement_attorneys_act_overview(lpa).should == "The replacement attorneys will act jointly and severally"
    end
    it "should display some jointly, some sepreately accurately" do
      lpa = Lpa.new(:how_replacement_attorneys_act => "Jointly for some decisions, and jointly and severally for other decisions")
      helper.how_replacement_attorneys_act_overview(lpa).should == "The replacement attorneys will act jointly for some decisions, and jointly and severally for other decisions"
    end
  end


  describe "life_sustaining_overview" do
    it "should return nil if a property lpa" do
      lpa = Lpa.new(:type => "Property and financial affairs")
      helper.life_sustaining_overview(lpa).should == nil
    end
    it "should return correctly for option a" do
      lpa = Lpa.new(:type => "Health and welfare", :life_sustaining_treatment => "Option A")
      helper.life_sustaining_overview(lpa).should == "The attorneys can make decisions about life-sustaining treatment on the donor's behalf"
    end
    it "should return correctly for option b" do
      lpa = Lpa.new(:type => "Health and welfare", :life_sustaining_treatment => "Option B")
      helper.life_sustaining_overview(lpa).should == "The attorneys can't make decisions about life-sustaining treatment on the donor's behalf"
    end
  end

  describe "when_to_use_overview" do
    it "should return nil if a healthcare lpa" do
      lpa = Lpa.new(:type => "Health and welfare")
      helper.when_to_use_overview(lpa).should == nil
    end
    it "should return correctly for option a" do
      lpa = Lpa.new(:type => "Property and financial affairs", :when_to_use => "as soon as it's registered (with my consent)")
      helper.when_to_use_overview(lpa).should == "The LPA can be used as soon as it's registered (with my consent)"
    end
    it "should return correctly for option b" do
      lpa = Lpa.new(:type => "Property and financial affairs", :when_to_use => "only if I don't have mental capacity")
      helper.when_to_use_overview(lpa).should == "The LPA can be used only if I don't have mental capacity"
    end
  end

end
