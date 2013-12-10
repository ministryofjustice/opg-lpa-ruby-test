require 'builder'

class PDFMaker
  attr_writer :json

  def initialize(json)
    @json = json
  end

  def to_pdf
    xfdf = create_xfdf(create_donor)
    populate_form(xfdf)
  end

  private

  def populate_form(xfdf)
    rnd = Random.new.rand(1..100000000) + 1
    input = File.join "..", "..", "templates", "input#{rnd}.xfdf"
    path = File.open("#{input}", 'w+').path
    File.open(path, 'w') {|f| f.write(xfdf) }
    template = File.join "..", "..", "templates", "lpa.pdf"
    result = File.join "..", "..", "public", "output#{rnd}.pdf"
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
    result
  end

  def create_donor
    JSONFormatter.new(@json).to_form_data
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
