require 'spec_helper'

describe PeopleToBeTold do
  context "given three people that need to be told" do
    let(:pdf_file) { "#{Rails.root}/templates/lpa.pdf" }
    let(:json) { three_people_json }

    context "when filling out their details" do
      before(:all) do
        cont_pdfs = File.join(Rails.root, "pdfs", "drafts", "*.pdf")
        Dir.glob(cont_pdfs).each do |f|
          File.delete f
        end
        FileUtils.cp File.join(Rails.root, "templates", "lpa.pdf"), File.join(Rails.root, "pdfs", "drafts", "52cbe33977696e6f0a000000.pdf")
      end

      it "should generate continuation sheets" do
        pdfs_dir = "#{Rails.root}/pdfs/drafts/*"
        count = Dir[pdfs_dir].length
        PeopleToBeTold.new(pdf_file, json).fill_forms
        Dir[pdfs_dir].length.should eq (count + 2)
      end

      describe "continuation sheet should be added to the main LPA PDF" do
        let(:lpa_id) { "52a72c0377696e03df020000" }
        let(:file) { File.join("#{Rails.root}", "pdfs", "drafts", "#{lpa_id}.pdf") }
        let(:pages) { %x[pdftk #{file} dump_data | awk '/NumberOfPages/ {print $2}'] }

        it "should have the correct number of pages" do
          pages.to_i.should eq 18
        end
      end
    end
  end
end
