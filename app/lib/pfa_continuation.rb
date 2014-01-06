class PFAContinuation

  def initialize(lpa_id, json)
    @lpa_id = lpa_id
    @json = json
  end

  def to_pdf
    result = "pdfs/drafts/#{@lpa_id}.pdf"
    a3 = "templates/PFA_continuation_A3.pdf"
    output = "#{result}-a3"
    system "pdftk #{result} #{a3} cat output #{output}"
    File.rename(output, result)
  end
end
