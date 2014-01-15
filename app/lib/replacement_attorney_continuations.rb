class ReplacementAttorneyContinuations
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
    @hash["Line4"] = ""
    @hash["Line5"] = get_dob
    @hash
  end

  private

  def first_line
    num = (@hash["sheetNumber"].to_i + 1).to_words
    "Replacement Attorney number #{num}"
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

  def get_dob
    "DOB: #{@data["date_of_birth"]}"
  end
end
