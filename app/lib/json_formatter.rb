class JSONFormatter
  attr_writer :json

  def initialize(json)
    @json = JSON.parse json
  end

  def to_form_data
    yml = YAML::load File.open File.join Rails.root, "config", "pdf-form-map.yml"
    result = {}
    yml.keys.each do |k|
      result[k] = get_yml_value(yml[k])
    end
    result
  end

  private

  def get_yml_value(string)
    string.gsub(' ', '').split(',').inject(@json,:[])
  end
end
