require_relative 'pdf_maker'

class PDFWorker
  include Sidekiq::Worker

  def perform(lpa_id, json)
    PDFMaker.new(lpa_id, json).to_pdf
  end
end
