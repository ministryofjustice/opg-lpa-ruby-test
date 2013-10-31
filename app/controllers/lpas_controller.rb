class LpasController < ApplicationController
  before_filter :check_applicant
  def index
    @lpas = Applicant.find(session[:applicant_id]).lpas
  end

  def create
    @lpa = Lpa.create(:applicant_id => session[:applicant_id])
    redirect_to lpa_build_index_path(:lpa_id => @lpa.id)
  end
  
  private
  def check_applicant
    unless session[:applicant_id].present?
      redirect_to new_applicant_path
    end
  end
end