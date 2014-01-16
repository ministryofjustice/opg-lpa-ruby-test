require 'spec_helper'

def second_replacement_attorney
  {
    "address" => {
      "address_line1" => "1 Streety Road",
      "address_line2" => "Nice Area",
      "address_line3" => "",
      "town" => "Lawsburgh",
      "county" => "",
      "post_code" => "L1",
      "country" => "United Kingdom"
    },
    "id" => "52ce8f7077696e724cc00000",
    "date_of_birth" => "1894-01-01",
    "title" => "Mr",
    "first_name" => "Genghis",
    "middle_names" => "",
    "last_name" => "Khan",
    "phone" => "",
    "email" => ""
  }
end

def replacement_attorney_parsed
  {
    "totalSheets" => "1",
    "sheetNumber" => "1",
    "Line1" => "Replacement Attorney number two",
    "Line2" => "Mr Genghis Khan",
    "Line3" => "1 Streety Road, Nice Area, Lawsburgh, L1, United Kingdom",
    "Line4" => "",
    "Line5" => "DOB: 1894-01-01"
  }
end

def continuation_c
  { "fullName_auth_sig_1" => "Genghis Khan" }
end

describe ReplacementAttorneyContinuations do
  context "when a person to be told is shown" do
    let(:cont) { ReplacementAttorneyContinuations.new(1, 1, second_replacement_attorney) }

    describe "#continuationA1" do
      it "should generate correct fields to fill" do
        cont.continuation_a1.should eq replacement_attorney_parsed
      end
    end

    describe "#continuation_c" do
      it "should generate correct fields to fill" do
        cont.continuation_c.should eq continuation_c
      end
    end
  end
end
