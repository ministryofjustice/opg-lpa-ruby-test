class LpasController < ApplicationController
  before_filter :check_applicant

  def index
    @lpas = @applicant.lpas
  end

  def create
    with_secure_token(Lpa) do
      @lpa = Lpa.create(:applicant_id => @applicant.id)
      redirect_to lpa_build_index_path(:lpa_id => @lpa.id)
    end
  end

  def show
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:id])
      render :json => @lpa
    end
  end

  def pdf
    send_file(draft_pdf_path, :filename => "draft.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def get_pdf
    if @applicant.has_lpa? params[:lpa_id]
      puts lpa_pdf_path
      @pdf_url = File.exist?(draft_pdf_path) ? lpa_pdf_path : false
      respond_to do |format|      
        format.html { pdf if @pdf_url }
        format.js {render json: {pdfURL: @pdf_url}}
      end
    end
  end

  def preview_pdf
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:lpa_id])
      @lpa_id = params[:lpa_id]
      puts "Calling PDFWORKERRRRRRRRRRRR for #{@lpa_id}"
      PDFWorker.perform_async(@lpa_id, @lpa.to_json)
      puts "Called PDFWORKERRRRRRRRRRRR"
      respond_to do |format|
        format.js
        format.html { get_pdf }
      end
    end
  end

  private
  def draft_pdf_path
    "#{Rails.root}/pdfs/drafts/#{params[:lpa_id]}.pdf"
  end

  def check_applicant
    with_secure_token(Applicant) do
      unless @applicant = Applicant.current_applicant
        redirect_to new_applicant_path
      end
    end
  end
end
