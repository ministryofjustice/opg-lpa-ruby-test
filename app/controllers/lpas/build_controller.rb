class Lpas::BuildController < ApplicationController
  before_filter :check_applicant
  include Wicked::Wizard

  steps :type, :donor, :when_to_use

  def show
    @lpa = Lpa.find(params[:lpa_id])
    if step == :donor
      @lpa.donor = @lpa.donor || Donor.new
    end
    render_wizard
  end

  def update
    @lpa = Lpa.find(params[:lpa_id])
    @lpa.update_attributes(params[:lpa])
    render_wizard @lpa
  end

  private
  def check_applicant
    unless session[:applicant_id].present?
      redirect_to new_applicant_path
    end
  end
end
