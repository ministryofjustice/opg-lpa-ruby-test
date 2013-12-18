require 'spec_helper'

def third_attorney
  {
    "address" => {
      "address_line1" => "Attorney3 addr_line1",
      "address_line2" => "Attorney3 addr_line2",
      "address_line3" => "Attorney3 addr_line3",
      "town" => "Attorney3 town",
      "county" => "Attorney3 county",
      "post_code" => "Attorney3 post code",
      "country" => "Attorney3 country"
    },
    "id" => "52a873fe77696e05b90a0000",
    "date_of_birth" => "2013-12-11",
    "title" => "Mr",
    "first_name" => "Attorney3_name",
    "middle_names" => "",
    "last_name" => "Attorney3_surname",
    "phone" => "",
    "email" => ""
  }
end

def attorney_parsed
  {
    "totalSheets" => "1",
    "sheetNumber" => "1",
    "Line1" => "Third attorney",
    "Line2" => "Mr Attorney3_name Attorney3_surname",
    "Line3" => "Attorney3 addr_line1, Attorney3 addr_line2, Attorney3 addr_line3, Attorney3 town, Attorney3 county, Attorney3 post code, Attorney3 country",
    "Line4" => "",
    "Line5" => "DOB: 2013-12-11"
  }
end


describe AttorneyContinuations do

  context "when a attorney continuation is required" do

    describe "#continuationA1" do
      let(:cont) { AttorneyContinuations.new(1, 1, third_attorney) }

      it "should set the correct attorney count in numbers" do
        cont.continuationA1["Line1"].should eq "Third attorney"
      end

      it "should generate correct fields to fill" do
        cont.continuationA1.should eq attorney_parsed
      end
    end
  end

end
