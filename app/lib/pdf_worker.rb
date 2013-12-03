require_relative 'pdf_maker'

class PDFWorker
  include Sidekiq::Worker

  def perform(json)
    PDFMaker.new(json).to_pdf
  end
end
