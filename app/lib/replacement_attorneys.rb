class ReplacementAttorneys
  def initialize(pdf, data)
    @data = JSON.parse data
    @lpa_id = @data["id"]
  end

  def fill_forms
    attorneys = get_extra_replacement_attorneys
    total_continuations = attorneys.count

    attorneys.each_with_index do |attorney, index|
      populate_continuations ReplacementAttorneyContinuations.new(total_continuations, (index + 1), attorney)
      concatenate_continuations
    end
  end

  private

  def get_extra_replacement_attorneys
    @data["replacement_attorneys"].drop(1)
  end

  def populate_continuations data
    populate_a1 data
    populate_c data
  end

  def populate_a1 data
    path = File.open("templates/continuation_A1_#{@lpa_id}.xfdf", 'w+').path
    template =  File.join(Rails.root, "templates", "PFA_continuation_A1.pdf")
    result = File.join("pdfs", "drafts", "continuation_A1_#{@lpa_id}.pdf")
    fill_pdf data.continuationA1, path, template, result
  end

  def populate_c(data)
    path = File.open("templates/continuation_C_#{@lpa_id}.xfdf", 'w+').path
    template =  File.join(Rails.root, "templates", "PFA_continuation_C.pdf")
    result = File.join("pdfs", "drafts", "continuation_C_#{@lpa_id}.pdf")
    fill_pdf data.continuation_c, path, template, result
  end

  def fill_pdf(data, path, template, result)
    xfdf = XFDFMaker.new(data)
    File.open(path, 'w') {|f| f.write(xfdf.create) }
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
  end

  def concatenate_continuations
    lpa = File.join("pdfs", "drafts", "#{@lpa_id}.pdf")
    a1 = File.join("pdfs", "drafts", "continuation_A1_#{@lpa_id}.pdf")
    c = File.join("pdfs", "drafts", "continuation_C_#{@lpa_id}.pdf")
    output = File.join("pdfs", "drafts", "#{@lpa_id}-done.pdf")
    system "pdftk #{lpa} #{a1} #{c} cat output #{output}"
    File.rename(output, lpa)
  end

end
