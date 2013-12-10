require 'builder'

class PDFMaker
  attr_writer :json

  def initialize(lpa_id, json)
    @lpa_json = json
    @lpa_id = lpa_id
  end

  def to_pdf
    xfdf = create_xfdf(create_donor)
    populate_form(xfdf)
  end

  private

  def populate_form(xfdf)
    path = File.open("templates/input#{@lpa_id}.xfdf", 'w+').path
    File.open(path, 'w') {|f| f.write(xfdf) }
    template = "templates/lpa.pdf"
    result = "pdfs/drafts/#{@lpa_id}.pdf"
    # result = "public/drafts/#{@lpa_id}.pdf"
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
    result
  end

  def create_donor
    JSONFormatter.new(@lpa_json).to_form_data
  end

  def create_xfdf(fields)
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.xfdf("xmlns" => "http://ns.adobe.com/xfdf/", "xml:space" => "preserve") {
      xml.fields {
        fields.each do |field, value|
          xml.field(:name => field) {
            if value.is_a? Array
              value.each {|item| xml.value(item.to_s) }
            else
              xml.value(value.to_s)
            end
          }
        end
      }
    }
    xml.target!
  end
end
