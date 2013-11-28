require 'spec_helper'

describe PDFMaker do

  describe "#to_pdf" do
    let(:doc) { PDFMaker.new(donor_json) }
    pdf_file = "#{Rails.root}/public/output.pdf"

    it "should respond to :to_pdf" do
      doc.respond_to?(:to_pdf).should be_true
    end

    it "should create a new PDF file" do
      doc.to_pdf
      File.exists?(pdf_file).should be_true
    end

    it "should add donor data to a PDF file" do
      good_md5 = "9b87eee5fe8ddc90136eb1c5d3220dee"
      Digest::MD5.hexdigest(File.read(pdf_file)).should eq good_md5
    end
  end
end
