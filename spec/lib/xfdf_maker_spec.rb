require 'spec_helper'

def xfdf_doc
'<?xml version="1.0" encoding="UTF-8"?>
<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
  <fields>
    <field name="one">
      <value>1</value>
    </field>
    <field name="two">
      <value>2</value>
    </field>
    <field name="hello">
      <value>greet</value>
    </field>
  </fields>
</xfdf>
'
end

describe XFDFMaker do
  context "when given a hash" do
    let(:hash) { { "one" => 1, "two" => 2, "hello" => "greet" } }
    let(:data) { Nokogiri::XML(XFDFMaker.new(hash).create) }

    it "should turn it into a XFDF document" do
      data.to_xml.should eq xfdf_doc
    end
  end
end
