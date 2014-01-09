require 'spec_helper'

describe PFAContinuation do
  before do
    lpa = File.join Rails.root, "templates", "lpa.pdf"
    @pdf = File.join Rails.root, "pdfs", "drafts", "987.pdf"
    FileUtils.cp(lpa, @pdf)
  end

  describe "#add" do
    it "should add A3 PFA continuation" do
      lpa_id = "987"
      pdf = PFAContinuation.new(lpa_id, three_attorneys_json).to_pdf
      pages = %x[pdftk #{@pdf} dump_data | awk '/NumberOfPages/ {print $2}']
      pages.to_i.should eq 16
    end
  end
end
