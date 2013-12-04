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
    # TODO: fix the paths!
    path = File.open("templates/input#{@lpa_id}.xfdf", 'w+').path
    File.open(path, 'w') {|f| f.write(xfdf) }
    template = "templates/lpa.pdf"
    result = "public/draft_#{@lpa_id}.pdf"
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
    result
  end

  def create_donor
    hash = {}
    j = JSON.parse @lpa_json
    hash['cb_Page3DonorTitle'] = j["donor"]["title"]
    hash['PartADonorFirstName'] = j["donor"]["first_name"]
    hash['PartADonorLastName'] = j["donor"]["last_name"]
    hash['PartADonorDOB'] = j["donor"]["date_of_birth"]
    hash['PartADonorAddress1'] = j["donor"]["address"]["address_line1"]
    hash['PartADonorAddress2'] = j["donor"]["address"]["address_line2"]
    hash['PartADonorAddress3'] = j["donor"]["address"]["address_line3"]
    hash['PartADonorPostcode'] = j["donor"]["address"]["post_code"]
    hash
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
