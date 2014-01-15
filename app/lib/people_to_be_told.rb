class PeopleToBeTold
  def initialize(pdf, data)
    @pdf = pdf
    @data = JSON.parse data
    @lpa_id = @data["id"]
  end

  def fill_forms
    people = get_extra_people
    total_continuations = people.count
    count = 0
    people.each do |person|
      count += 1
      populate_continuation PeopleContinuations.new(total_continuations, count, person)
      concatenate_continuations
    end
  end

  private

  def get_extra_people
    @data["people_to_be_told"].drop(2)
  end

  def populate_continuation data
    path = File.open("templates/continuation_A1_#{@lpa_id}.xfdf", 'w+').path
    template =  File.join(Rails.root, "templates", "PFA_continuation_A1.pdf")
    result = File.join("pdfs", "drafts", "continuation_A1_#{@lpa_id}.pdf")
    fill_pdf data.continuationA1, path, template, result
  end

  def fill_pdf(data, path, template, result)
    xfdf = XFDFMaker.new(data)
    File.open(path, 'w') {|f| f.write(xfdf.create) }
    system "pdftk #{template} fill_form #{path} output #{result} flatten"
  end

  def concatenate_continuations
    lpa = File.join("pdfs", "drafts", "#{@lpa_id}.pdf")
    a1 = File.join("pdfs", "drafts", "continuation_A1_#{@lpa_id}.pdf")
    output = File.join("pdfs", "drafts", "#{@lpa_id}-done.pdf")
    system "pdftk #{lpa} #{a1} cat output #{output}"
    File.rename(output, lpa)
  end
end
