require_relative 'pdf_maker'

class PDFWorker
  include Sidekiq::Worker

  def perform(lpa_id, json)
    puts "WORKERRRRRRRRRRRR"
    PDFMaker.new(lpa_id, json).to_pdf
  end
end
