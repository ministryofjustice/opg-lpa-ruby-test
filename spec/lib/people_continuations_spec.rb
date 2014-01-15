require 'spec_helper'

def third_person
  {
    "address" => {
      "address_line1" => "1 Buckingham Palace Road",
      "address_line2" => "",
      "address_line3" => "",
      "town" => "London",
      "county" => "",
      "post_code" => "SW1A 1AA",
      "country" => "United Kingdom"
    },
    "title" => "Dr",
    "first_name" => "ThirdPerson",
    "middle_names" => "",
    "last_name" => "ThirdPersonLastName"
  }
end

def person_parsed
  {
    "totalSheets" => "1",
    "sheetNumber" => "1",
    "Line1" => "Notified Person number three",
    "Line2" => "Dr ThirdPerson ThirdPersonLastName",
    "Line3" => "1 Buckingham Palace Road, London, SW1A 1AA, United Kingdom"
  }
end


describe PeopleContinuations do
  context "when a person to be told is shown" do
    let(:cont) { PeopleContinuations.new(1, 1, third_person) }

    describe "#continuationA1" do
      it "should set the correct people count in numbers" do
        cont.continuationA1["Line1"].should eq "Notified Person number three"
      end

      it "should generate correct fields to fill" do
        cont.continuationA1.should eq person_parsed
      end
    end
  end
end
