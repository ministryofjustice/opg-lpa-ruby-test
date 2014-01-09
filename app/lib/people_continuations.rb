class PeopleContinuations

  def initialize(total_sheets, sheet_no, data)
    @data = data
    @hash = {}
    @hash["totalSheets"] = total_sheets.to_s
    @hash["sheetNumber"] = sheet_no.to_s
  end

  def continuationA1
    @hash["Line1"] = first_line
    @hash["Line2"] = get_name_with_title
    @hash["Line3"] = get_address
    @hash
  end

  def continuationC1
    { "fullName_auth_sig_1" => "#{get_full_name}" }
  end

  private

  def first_line
    num = (@hash["sheetNumber"].to_i + 2).to_words
    "Notified Person number #{num}"
  end

  def get_full_name
    "#{@data["first_name"]} #{@data["last_name"]}"
  end

  def get_name_with_title
    "#{@data["title"]} #{get_full_name}"
  end

  def get_address
    arr = []
    ["address_line1", "address_line2", "address_line3",
     "town", "county", "post_code", "country"].each do |entry|
      value = @data["address"][entry]
      arr << value unless value.empty?
    end
    arr.join(', ')
  end

end
