class LpasController < ApplicationController
  before_filter :check_applicant

  def index
    with_secure_token(Applicant) do
      @lpas = Applicant.find(session[:applicant_id]).lpas
    end
  end

  def create
    with_secure_token(Lpa) do
      @lpa = Lpa.create(:applicant_id => session[:applicant_id])
      redirect_to lpa_build_index_path(:lpa_id => @lpa.id)
    end
  end

  def show
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:id])
      render :json => @lpa
    end
  end

  private
  def check_applicant
    unless session[:applicant_id].present?
      redirect_to new_applicant_path
    end
  end
end