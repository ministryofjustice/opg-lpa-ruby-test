require 'builder'

class XFDFMaker
  def initialize(data)
    @fields = data
  end

  def create
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.xfdf("xmlns" => "http://ns.adobe.com/xfdf/", "xml:space" => "preserve") {
      xml.fields {
        @fields.each do |field, value|
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
