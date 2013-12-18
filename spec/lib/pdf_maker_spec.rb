require 'spec_helper'

describe PDFMaker do
  describe "#to_pdf" do
    before(:each) do
      system("rm -f #{@pdf_filename}")
      lpa_id = "529609ed77696e052c490100"
      PDFMaker.new(lpa_id, donor_json).to_pdf
      @pdf_filename = "#{Rails.root}/pdfs/drafts/#{lpa_id}.pdf"
    end

    it "should create a new PDF file" do
      File.exists?(@pdf_filename).should be_true
    end

    pending "should add correct data to a PDF file" do
      good_md5 = Digest::MD5.hexdigest(File.read("spec/support/sample_lpa.pdf"))
      Digest::MD5.hexdigest(File.read(@pdf_filename)).should eq good_md5
    end

    context "when there are more than 2 attorneys" do
      describe "the generated PDF" do

        it "should have a continuation sheet attached" do
          lpa_id = "52a72c0377696e03df020000"
          pdf = PDFMaker.new(lpa_id, three_attorneys_json).to_pdf
          pages = %x[pdftk #{pdf} dump_data | awk '/NumberOfPages/ {print $2}']
          pages.to_i.should eq 16
        end

        it "should have attorney data"
      end
    end

  end
end
