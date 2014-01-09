class JSONFormatter
  attr_writer :json

  def initialize(json)
    @json = JSON.parse json
  end

  def to_form_data
    result = {}
    result.merge! populate_values
    if has_attorneys?
      attorney_yaml = ["attorney-1.yml", "attorney-2.yml"]
      result.merge! get_values(attorney_yaml, "attorneys")
      result.merge!(populate_continuations_count)
    end
    result.merge! restrictions if has_restriction?
    result.merge! attorney_decisions if mixed_attorney_decisions?
    people_yaml = ["person-1.yml", "person-2.yml"]
    result.merge! get_values(people_yaml, "people_to_be_told") if people_to_be_told?
    result
  end

  private

  def has_attorneys?
    has_value? "attorneys"
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

  def populate_continuations_count
    count = @json["attorneys"].size
    size = ( count > 2) ? (count - 2) : 0
    {
      "Page1A1SheetCount" => size,
      "Page1CSheetCount" => size,
      "Page1TotalContSheetCount" => (size * 2)
    }
  end

  def has_restriction?
    @json["when_to_use"] == "only if I don\'t have mental capacity"
  end

  def restrictions
    { "Restrictions" => "I would like my LPA to take effect only when I lose capacity to make decisions about my property and financial affairs"}
  end

  def mixed_attorney_decisions?
    msg = "Jointly for some decisions, and jointly and severally for other decisions"
    @json["how_attorneys_act"] == msg
  end

  def attorney_decisions
    { "AttorneyDecisionsInstructions" => @json["how_attorneys_act_details"] }
  end

  def people_to_be_told?
    has_value? "people_to_be_told"
  end

  def get_values(yaml_files, desired_key)
    result = {}
    count = 0
    yaml_files.each do |file|
      yml = YAML::load File.open File.join Rails.root, "config", file
      yml.keys.each do |k|
        result[k] = get_yml_value(@json[desired_key][count], yml[k])
      end
      count += 1
    end
    result
  end

  def has_value?(val)
    (@json[val].size > 0) if @json.key? val
  end

end
