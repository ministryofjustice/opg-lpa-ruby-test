require 'spec_helper'

def three_replacement_attorneys
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
        "first_name": "Aleksandar",
        "middle_names": "",
        "last_name": "Simic",
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
        },
        {
            "address": {
                "address_line1": "1 Buckingham Palace Road",
                "address_line2": "",
                "address_line3": "",
                "town": "London",
                "county": "",
                "post_code": "SW1A 1AA",
                "country": "United Kingdom"
            },
            "title": "Dr",
            "first_name": "ThirdPerson",
            "middle_names": "",
            "last_name": "ThirdPersonLastName"
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
        },
        {
            "address": {
                "address_line1": "1 Roady Road",
                "address_line2": "",
                "address_line3": "",
                "town": "London",
                "county": "",
                "post_code": "SW1",
                "country": ""
            },
            "id": "52d7ba0077696e724cec0100",
            "date_of_birth": "1970-09-01",
            "title": "",
            "first_name": "Attorney2",
            "middle_names": "",
            "last_name": "Attorney2",
            "phone": "",
            "email": ""
        },
        {
            "address": {
                "address_line1": "77 River Road",
                "address_line2": "",
                "address_line3": "",
                "town": "London",
                "county": "",
                "post_code": "W1",
                "country": ""
            },
            "id": "52d7ba2f77696e724c000200",
            "date_of_birth": "1901-09-05",
            "title": "Mrs",
            "first_name": "Attorney3",
            "middle_names": "",
            "last_name": "Attorney3",
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
        "first_name": "Aleksandar",
        "middle_names": "",
        "last_name": "Simic"
    }
  }'
end



describe ReplacementAttorneys do
  context "given three people that need to be told" do
    let(:pdf_file) { "#{Rails.root}/templates/lpa.pdf" }
    let(:json) { three_replacement_attorneys }
    let(:lpa_id) { "52cae0c677696e39bc260000" }

    context "when filling out their details" do
      before(:all) do
        cont_pdfs = File.join(Rails.root, "pdfs", "drafts", "*.pdf")
        Dir.glob(cont_pdfs).each do |f|
          File.delete f
        end
        FileUtils.cp File.join(Rails.root, "templates", "lpa.pdf"), File.join(Rails.root, "pdfs", "drafts", "52cae0c677696e39bc260000.pdf")
      end

      it "should generate continuation sheets" do
        pdfs_dir = "#{Rails.root}/pdfs/drafts/*"
        count = Dir[pdfs_dir].length
        ReplacementAttorneys.new(pdf_file, json).fill_forms
        Dir[pdfs_dir].length.should eq (count + 1)
      end

      describe "continuation sheets should be added to the main LPA PDF" do

        let(:file) { File.join("#{Rails.root}", "pdfs", "drafts", "#{lpa_id}.pdf") }
        let(:pages) { %x[pdftk #{file} dump_data | awk '/NumberOfPages/ {print $2}'] }

        it "should have the correct number of pages" do
          pages.to_i.should eq 18
        end
      end
    end
  end
end
