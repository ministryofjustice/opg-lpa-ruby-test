require 'spec_helper'


def json_data
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
    "certificate_provider": {
        "address": {
            "address_line1": "",
            "address_line2": "",
            "address_line3": "",
            "town": "",
            "county": "",
            "post_code": "",
            "country": ""
        },
        "title": "Mr",
        "first_name": "First",
        "middle_names": "",
        "last_name": "Last",
        "email": ""
    },
    "certificate_provider2": null,
    "people_to_be_told": [
        {
            "address": {
                "address_line1": "1 PTBT Street",
                "address_line2": "",
                "address_line3": "",
                "town": "London",
                "county": "",
                "post_code": "W1",
                "country": "London"
            },
            "title": "Mr",
            "first_name": "PersonToBeTold",
            "middle_names": "",
            "last_name": "PersonToBeToldLastname"
        },
        {
            "address": {
                "address_line1": "2 Secondy Street",
                "address_line2": "",
                "address_line3": "",
                "town": "London",
                "county": "",
                "post_code": "W2",
                "country": ""
            },
            "title": "Miss",
            "first_name": "Lady2",
            "middle_names": "",
            "last_name": "LadyLady2"
        }
    ],
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
    "replacement_attorneys": [
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
            "id": "52ce8f7077696e724cc00000",
            "date_of_birth": "1894-01-01",
            "title": "Mr",
            "first_name": "Replacement Attorney",
            "middle_names": "",
            "last_name": "RA LastName",
            "phone": "",
            "email": ""
        }
    ],
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


def valid_hash
  {
    "cb_Page3DonorTitle" => "Mr",
    "PartADonorFirstName" => "FirstName",
    "PartADonorLastName" => "LastName",
    "PartADonorOtherNames" => "",
    "PartADonorDOB" => "1900-01-01",
    "PartADonorAddress1" => "3 Streety Street",
    "PartADonorAddress2" => "",
    "PartADonorAddress3" => "",
    "PartADonorPostcode" => "SW1",
    "PartAAttorney1FirstName" => "First",
    "PartAAttorney1LastName" => "Attorney",
    "PartAAttorney1DOB" => "1894-01-01",
    "PartAAttorney1Address1" => "",
    "PartAAttorney1Address2" => "",
    "PartAAttorney1Address3" => "",
    "PartAAttorney1Postcode" => "",
    "PartAAttorney2FirstName" => "Second",
    "PartAAttorney2LastName" => "Attorney",
    "PartAAttorney2DOB" => "1894-01-01",
    "PartAAttorney2Address1" => "",
    "PartAAttorney2Address2" => "",
    "PartAAttorney2Address3" => "",
    "PartAAttorney2Postcode" => "",
    "Page1A1SheetCount" => 2,
    "Page1CSheetCount" => 2,
    "Page1TotalContSheetCount" => 4,
    "Restrictions" => "I would like my LPA to take effect only when I lose capacity to make decisions about my property and financial affairs",
    "AttorneyDecisionsInstructions" => "This is grand",
    "Notified1FirstName" => "PersonToBeTold",
    "Notified1LastName" => "PersonToBeToldLastname",
    "Notified1Address1" => "1 PTBT Street",
    "Notified1Address2" => "",
    "Notified1Address3" => "",
    "Notified1Postcode" => "W1",
    "Notified2FirstName" => "Lady2",
    "Notified2LastName" => "LadyLady2",
    "Notified2Address1" => "2 Secondy Street",
    "Notified2Address2" => "",
    "Notified2Address3" => "",
    "Notified2Postcode" => "W2"
  }
end

describe JSONFormatter do

  context "when the section 8 is filled in" do
    let(:formatter) { JSONFormatter.new(json_data) }

    it "should create the correct field" do
      formatter.to_form_data.should eq valid_hash
    end
  end
end
