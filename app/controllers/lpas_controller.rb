class LpasController < ApplicationController
  def index
    
  end

  def find
    redirect_to edit_lpa_path(params[:lpa])
  end

  def create
    @lpa = Lpa.create(:applicant_id => session[:applicant_id])
    redirect_to lpa_build_index_path(:lpa_id => @lpa.id)
  end
end