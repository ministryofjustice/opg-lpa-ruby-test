class PopulateAttorneys
  def initialize(pdf, data)
    @pdf = pdf
    @data = JSON.parse data
    @lpa_id = @data["id"]
  end

  def fill_forms
    attorneys = get_extra_attorneys
    total_continuations = attorneys.count
    count = 0
    attorneys.each do |attorney|
      count += 1
      continuation_data = AttorneyContinuations.new(total_continuations, count, attorney)
      xfdf = XFDFMaker.new(continuation_data.continuationA1)
      populate_form xfdf.create
      concatenate_continuation
    end
  end

  private

  def get_extra_attorneys
    @data["attorneys"].drop(2)
  end

  def populate_form(xfdf)
    path = File.open("templates/continuation_A1#{@lpa_id}.xfdf", 'w+').path
    File.open(path, 'w') {|f| f.write(xfdf) }
    template =  File.join(Rails.root, "templates", "PFA_continuation_A1.pdf")
    result = File.join("pdfs", "drafts", "continuation_A1_#{@lpa_id}.pdf")
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
  end

  def concatenate_continuation
    lpa = File.join("pdfs", "drafts", "#{@lpa_id}.pdf")
    continuation = File.join("pdfs", "drafts", "continuation_A1_#{@lpa_id}.pdf")
    output = File.join("pdfs", "drafts", "#{@lpa_id}-done.pdf")
    system "pdftk #{lpa} #{continuation} cat output #{output}"
    File.rename(output, lpa)
  end
end
