require 'spec_helper'

def good_hash
  {
    "PartADonorAddress1" => "1 Streety Street",
    "PartADonorAddress2" => "",
    "PartADonorAddress3" => "",
    "PartADonorDOB" => "2013-11-27",
    "PartADonorFirstName" => "First",
    "PartADonorLastName" => "Last",
    "PartADonorOtherNames" => "",
    "PartADonorPostcode" => "SW1",
    "cb_Page3DonorTitle" => "Mr",
  }
end


def two_attorneys
  '{
  "applicant": {
    "address": {
      "address_line1": "1 Streety Street",
      "address_line2": "",
      "address_line3": "",
      "country": "",
      "county": "",
      "post_code": "SW1",
      "town": ""
    },
    "date_of_birth": "2013-12-10",
    "first_name": "First",
    "id": "52a72c0177696e03df000000",
    "last_name": "Last",
    "lpas": [],
    "middle_names": "",
    "title": "Mr",
    "uri": "http://localhost/api/applicants.json/52a72c0177696e03df000000.json"
  },
  "attorneys": [
    {
      "address": {
        "address_line1": "Attorney Addr1",
        "address_line2": "Attorney Addr2",
        "address_line3": "Attorney Addr3",
        "country": "United Kingdom",
        "county": "London",
        "post_code": "SW1",
        "town": "London"
      },
      "date_of_birth": "2013-12-11",
      "email": "",
      "first_name": "Attorney",
      "id": "52a8662477696e05b9000000",
      "last_name": "Attorney Last",
      "middle_names": "Attorney Middle",
      "phone": "",
      "title": "Mr"
    },
    {
      "address": {
        "address_line1": "Attorney2 line1",
        "address_line2": "Attorney2 line2",
        "address_line3": "Attorney2 line3",
        "country": "United Kingdom",
        "county": "London",
        "post_code": "SW1",
        "town": "London"
      },
      "date_of_birth": "2013-12-11",
      "email": "Attorney2",
      "first_name": "Attorney2 firstname",
      "id": "52a86ad077696e05b9040000",
      "last_name": "Attorney2 lastname",
      "middle_names": "Attorney2",
      "phone": "Attorney2",
      "title": "Ms"
    }
  ],
  "certificate_provider": null,
  "certificate_provider2": null,
  "donor": {
    "address": {
      "address_line1": "1 Streety Street",
      "address_line2": "",
      "address_line3": "",
      "country": "",
      "county": "",
      "post_code": "SW1",
      "town": ""
    },
    "date_of_birth": "2013-12-10",
    "email": "",
    "first_name": "Donor",
    "last_name": "Donorski",
    "middle_names": "",
    "phone": "",
    "title": "Mr"
  },
  "id": "52a72c0377696e03df020000",
  "people_to_be_told": [],
  "replacement_attorneys": [],
  "type": "Property and financial affairs",
  "uri": "http://localhost/api/lpas.json/52a72c0377696e03df020000.json",
  "when_to_use": "only if I don\'t have mental capacity"
}'
end

def two_attorneys_hash
  {
    "Page1A1SheetCount" => 0,
    "Page1CSheetCount" => 0,
    "Page1TotalContSheetCount" => 0,

    "cb_Page3DonorTitle" => "Mr",
    "PartADonorAddress1" => "1 Streety Street",
    "PartADonorAddress2" => "",
    "PartADonorAddress3" => "",
    "PartADonorDOB" => "2013-12-10",
    "PartADonorFirstName" => "Donor",
    "PartADonorLastName" => "Donorski",
    "PartADonorOtherNames" => "",
    "PartADonorPostcode" => "SW1",
    "cb_Page3DonorTitle" => "Mr",

    "PartAAttorney1FirstName" => "Attorney",
    "PartAAttorney1LastName" => "Attorney Last",
    "PartAAttorney1DOB" => "2013-12-11",
    "PartAAttorney1Address1" => "Attorney Addr1",
    "PartAAttorney1Address2" => "Attorney Addr2",
    "PartAAttorney1Address3" => "Attorney Addr3",
    "PartAAttorney1Postcode" => "SW1",

    "PartAAttorney2FirstName" => "Attorney2 firstname",
    "PartAAttorney2LastName" => "Attorney2 lastname",
    "PartAAttorney2DOB" => "2013-12-11",
    "PartAAttorney2Address1" => "Attorney2 line1",
    "PartAAttorney2Address2" => "Attorney2 line2",
    "PartAAttorney2Address3" => "Attorney2 line3",
    "PartAAttorney2Postcode" => "SW1",

    "Restrictions" => "I would like my LPA to take effect only when I lose capacity to make decisions about my property and financial affairs"
  }
end

def three_attorneys_hash
  {
    "Page1A1SheetCount" => 1,
    "Page1CSheetCount" => 1,
    "Page1TotalContSheetCount" => 2,
    "PartAAttorney1Address1" => "Attorney",
    "PartAAttorney1Address2" => "Attorney",
    "PartAAttorney1Address3" => "Attorney",
    "PartAAttorney1DOB" => "2013-12-11",
    "PartAAttorney1FirstName" => "Attorney",
    "PartAAttorney1LastName" => "Attorney",
    "PartAAttorney1Postcode" => "Attorney",
    "PartAAttorney2Address1" => "Attorney2",
    "PartAAttorney2Address2" => "Attorney2",
    "PartAAttorney2Address3" => "Attorney2",
    "PartAAttorney2DOB" => "2013-12-11",
    "PartAAttorney2FirstName" => "Attorney2",
    "PartAAttorney2LastName" => "Attorney2",
    "PartAAttorney2Postcode" => "Attorney2",
    "PartADonorAddress1" => "",
    "PartADonorAddress2" => "",
    "PartADonorAddress3" => "",
    "PartADonorDOB" => "2013-12-10",
    "PartADonorFirstName" => "Donor",
    "PartADonorLastName" => "Donorski",
    "PartADonorOtherNames" => "",
    "PartADonorPostcode" => "",
    "cb_Page3DonorTitle" => "Mr"
  }
end

def attorney_decisions_jointly_for_some
  '{
    "donor": {
        "address": {
            "address_line1": "3 Streety Street",
            "address_line2": "",
            "address_line3": "",
            "town": "London",
            "county": "",
            "post_code": "SW1",
            "country": "United Kingdom"
        },
        "date_of_birth": "1900-01-01",
        "title": "Mr",
        "first_name": "FirstName",
        "middle_names": "",
        "last_name": "LastName",
        "phone": "",
        "email": ""
    },
    "certificate_provider": null,
    "certificate_provider2": null,
    "people_to_be_told": [],
    "attorneys": [
        {
            "address": {
                "address_line1": "",
                "address_line2": "",
                "address_line3": "",
                "town": "",
                "county": "",
                "post_code": "",
                "country": ""
            },
            "id": "52cbe33977696e6f0a000000",
            "date_of_birth": "1894-01-01",
            "title": "Mr",
            "first_name": "First",
            "middle_names": "",
            "last_name": "Attorney",
            "phone": "",
            "email": ""
        },
        {
            "address": {
                "address_line1": "",
                "address_line2": "",
                "address_line3": "",
                "town": "",
                "county": "",
                "post_code": "",
                "country": ""
            },
            "id": "52cbe34a77696e6f0a040000",
            "date_of_birth": "1894-01-01",
            "title": "Mr",
            "first_name": "Second",
            "middle_names": "",
            "last_name": "Attorney",
            "phone": "",
            "email": ""
        },
        {
            "address": {
                "address_line1": "",
                "address_line2": "",
                "address_line3": "",
                "town": "",
                "county": "",
                "post_code": "",
                "country": ""
            },
            "id": "52cbe3a577696e6f0a0a0000",
            "date_of_birth": "1925-02-01",
            "title": "Ms",
            "first_name": "Third",
            "middle_names": "",
            "last_name": "Attorney",
            "phone": "",
            "email": ""
        },
        {
            "address": {
                "address_line1": "",
                "address_line2": "",
                "address_line3": "",
                "town": "",
                "county": "",
                "post_code": "",
                "country": ""
            },
            "id": "52cc0aa577696e724c120000",
            "date_of_birth": "1919-02-01",
            "title": "Ms",
            "first_name": "Yes",
            "middle_names": "",
            "last_name": "No",
            "phone": "",
            "email": ""
        }
    ],
    "replacement_attorneys": [],
    "id": "52cae0c677696e39bc260000",
    "uri": "http://localhost/api/lpas.json/52cae0c677696e39bc260000.json",
    "type": "Property and financial affairs",
    "when_to_use": "only if I don\'t have mental capacity",
    "how_attorneys_act": "Jointly for some decisions, and jointly and severally for other decisions",
    "how_attorneys_act_details": "This is grand",
    "applicant": {
        "address": {
            "address_line1": "3 Streety Street",
            "address_line2": "",
            "address_line3": "",
            "town": "London",
            "county": "",
            "post_code": "SW1",
            "country": "United Kingdom"
        },
        "lpas": [],
        "id": "52cae0c477696e39bc240000",
        "uri": "http://localhost/api/applicants.json/52cae0c477696e39bc240000.json",
        "date_of_birth": "1900-01-01",
        "title": "Mr",
        "first_name": "FirstName",
        "middle_names": "",
        "last_name": "LastName"
    }
  }'
end

def jointly_for_some_hash
  {
    "Page1A1SheetCount" => 2,
    "Page1CSheetCount" => 2,
    "Page1TotalContSheetCount" => 4,
    "PartAAttorney1Address1" => "",
    "PartAAttorney1Address2" => "",
    "PartAAttorney1Address3" => "",
    "PartAAttorney1DOB" => "1894-01-01",
    "PartAAttorney1FirstName" => "First",
    "PartAAttorney1LastName" => "Attorney",
    "PartAAttorney1Postcode" => "",
    "PartAAttorney2Address1" => "",
    "PartAAttorney2Address2" => "",
    "PartAAttorney2Address3" => "",
    "PartAAttorney2DOB" => "1894-01-01",
    "PartAAttorney2FirstName" => "Second",
    "PartAAttorney2LastName" => "Attorney",
    "PartAAttorney2Postcode" => "",
    "PartADonorAddress1" => "3 Streety Street",
    "PartADonorAddress2" => "",
    "PartADonorAddress3" => "",
    "PartADonorDOB" => "1900-01-01",
    "cb_Page3DonorTitle" => "Mr",
    "PartADonorFirstName" => "FirstName",
    "PartADonorLastName" => "LastName",
    "PartADonorOtherNames" => "",
    "PartADonorPostcode" => "SW1",
    "Restrictions" => "I would like my LPA to take effect only when I lose capacity to make decisions about my property and financial affairs",
    "AttorneyDecisionsInstructions" => "This is grand",
    "Restrictions" => "I would like my LPA to take effect only when I lose capacity to make decisions about my property and financial affairs",
  }
end


describe JSONFormatter do

  context "when only a donor is present" do
    let(:json) { donor_json }

    it "should only have data for donor" do
      JSONFormatter.new(json).to_form_data.should eq good_hash
    end
  end

  context "when there are two attorneys present" do
    let(:formatter) { JSONFormatter.new(two_attorneys) }

    it "should populate the fields for both attorneys" do
      formatter.to_form_data.should eq two_attorneys_hash
    end
  end

  context "when there are more than two attorneys present" do
    let(:formatter) { JSONFormatter.new(three_attorneys_json) }

    it "should populate the fields for both attorneys" do
      formatter.to_form_data.should eq three_attorneys_hash
    end
  end

  context "when the option 'when_to_use' is provided" do
    let(:formatter) { JSONFormatter.new(two_attorneys) }

    it "should create the correct field" do
      formatter.to_form_data.keys.should include "Restrictions"
    end
  end

  context "when the section 5, for property is filled in" do
    let(:formatter) { JSONFormatter.new(attorney_decisions_jointly_for_some) }

    it "should create the correct field" do
      formatter.to_form_data.should eq jointly_for_some_hash
    end
  end

end
