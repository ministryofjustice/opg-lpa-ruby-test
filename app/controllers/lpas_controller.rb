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

  private
  def check_applicant
    with_secure_token(Applicant) do
      unless @applicant = Applicant.current_applicant
        redirect_to new_applicant_path
      end
    end
  end
end