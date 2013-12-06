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

  def get_pdf
    filename = "draft_#{params[:lpa_id]}.pdf"
    @pdf_url = File.exist?("public/#{filename}") ? "/#{filename}" : false
    respond_to do |format|
      format.json {render json: {pdfURL: @pdf_url}}
    end
  end

  def preview_pdf
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:lpa_id])
      @lpa_id = params[:lpa_id]
      PDFWorker.perform_async(params[:lpa_id], @lpa.to_json)      
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  private
  def check_applicant
    with_secure_token(Applicant) do
      unless @applicant = Applicant.current_applicant
        redirect_to new_applicant_path
      end
    end
  end
end