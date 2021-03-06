class LpasController < ApplicationController
  before_filter :check_applicant

  def index
    @lpas = @applicant.lpas
  end

  def create
    @lpa = Lpa.create(:applicant_id => @applicant.id)
    redirect_to lpa_build_index_path(:lpa_id => @lpa.id)
  end

  def show
    @lpa = Lpa.find(params[:id])
    render :json => @lpa
  end

  def pdf
    send_file(draft_pdf_path, :filename => "draft.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def get_pdf
    if @applicant.has_lpa? params[:lpa_id]
      success = File.exist?(draft_pdf_path)
      @pdf_url = success ? lpa_pdf_path : false
      respond_to do |format|
        format.html { pdf if @pdf_url }
        format.js {render json: {success: success, pdfURL: @pdf_url}}
      end
    end
  end

  def preview_pdf
    @lpa = Lpa.find(params[:lpa_id])
    @lpa_id = params[:lpa_id]
    File.delete(draft_pdf_path) if File.exist? draft_pdf_path
    PDFWorker.perform_async(@lpa_id, @lpa.to_json)
    respond_to do |format|
      format.js
      format.html { redirect_to lpa_get_pdf_path }
    end
  end

  private
  def draft_pdf_path
    "#{Rails.root}/pdfs/drafts/#{params[:lpa_id]}.pdf"
  end

  def check_applicant
    @applicant = Applicant.current_applicant
    redirect_to new_applicant_path unless @applicant
  end
end
