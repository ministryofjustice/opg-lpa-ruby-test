require 'builder'

class PDFMaker
  attr_writer :json

  def initialize(lpa_id, json)
    @lpa_json = json
    @lpa_id = lpa_id
  end

  def to_pdf
    xfdf = XFDFMaker.new(create_donor).create
    populate_form(xfdf)
    lpa_pdf = File.join Rails.root, "pdfs", "drafts", "#{@lpa_id}.pdf"
    PopulateAttorneys.new(lpa_pdf, @lpa_json).fill_forms
    lpa_pdf
  end

  private

  def populate_form(xfdf)
    path = File.open("templates/input#{@lpa_id}.xfdf", 'w+').path
    File.open(path, 'w') {|f| f.write(xfdf) }
    template = "templates/lpa.pdf"
    result = "pdfs/drafts/#{@lpa_id}.pdf"
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
    result
  end

  def create_donor
    JSONFormatter.new(@lpa_json).to_form_data
  end
end
