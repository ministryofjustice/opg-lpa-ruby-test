require 'spec_helper'

def donor_json
  '{
    "applicant": {
      "address": {
        "address_line1": "1 Streety Street",
        "address_line2": "",
        "address_line3": "",
        "country": "UK",
        "county": "London",
        "post_code": "SW1",
        "town": "London"
      },
      "date_of_birth": "2013-11-27",
      "email": "",
      "first_name": "Testy",
      "id": "529609eb77696e052c470100",
      "last_name": "Test",
      "lpas": [],
      "middle_names": "",
      "phone": "",
      "title": "Mr",
      "uri": "http://localhost/api/applicants.json/529609eb77696e052c470100.json"
    },
    "attorneys": [],
    "certificate_provider": null,
    "certificate_provider2": null,
    "donor": {
      "address": {
        "address_line1": "1 Streety Street",
        "address_line2": "",
        "address_line3": "",
        "country": "London",
        "county": "London",
        "post_code": "SW1",
        "town": "London"
      },
      "date_of_birth": "2013-11-27",
      "email": "",
      "first_name": "First",
      "last_name": "Last",
      "middle_names": "",
      "phone": "",
      "title": "Mr"
    },
    "id": "529609ed77696e052c490100",
    "people_to_be_told": [],
    "replacement_attorneys": [],
    "type": "Property and financial affairs",
    "uri": "http://localhost/api/lpas.json/529609ed77696e052c490100.json"
  }'
end


describe PDFMaker do
  describe "#to_pdf" do
    before(:each) do
      system("rm -f #{@pdf_filename}")
      lpa_id = "529609ed77696e052c490100"
      @doc = PDFMaker.new(lpa_id, donor_json).to_pdf
      @pdf_filename = "#{Rails.root}/pdfs/drafts/#{lpa_id}.pdf"
    end

    it "should create a new PDF file" do
      File.exists?(@pdf_filename).should be_true
    end

    pending "should add correct data to a PDF file" do
      good_md5 = Digest::MD5.hexdigest(File.read("spec/support/sample_lpa.pdf"))
      Digest::MD5.hexdigest(File.read(@pdf_filename)).should eq good_md5
    end
  end
end
