class JSONFormatter
  attr_writer :json

  def initialize(json)
    @json = JSON.parse json
  end

  def to_form_data
    result = {}
    result.merge! populate_values
    result.merge!(populate_attorneys) if has_attorneys?
    result
  end

  private

  def has_attorneys?
    (@json["attorneys"].size > 0) if @json.key? "attorneys"
  end

  def populate_values()
    hash = {}
    yml = YAML::load File.open File.join Rails.root, "config", "pdf-form-map.yml"
    yml.keys.each do |k|
      hash[k] = get_yml_value(@json, yml[k])
    end
    hash
  end

  def get_yml_value(hash, string)
    begin
      string.gsub(' ', '').split(',').inject(hash,:[])
    rescue NoMethodError
    end
  end

  def populate_attorneys
    attorney_result = {}
    count = 0
    ["attorney-1.yml", "attorney-2.yml"].each do |file|
      yml = YAML::load File.open File.join Rails.root, "config", file
      yml.keys.each do |k|
        attorney_result[k] = get_yml_value(@json["attorneys"][count], yml[k])
      end
      count += 1
    end
    attorney_result
  end
end
