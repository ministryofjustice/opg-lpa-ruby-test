require 'spec_helper'

describe PDFMaker do
  describe "#to_pdf" do
    before(:each) do
      system("rm -f #{@pdf_filename}")
      lpa_id = "529609ed77696e052c490100"
      @doc = PDFMaker.new(lpa_id, donor_json).to_pdf
      @pdf_filename = "#{Rails.root}/public/draft_#{lpa_id}.pdf"
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
