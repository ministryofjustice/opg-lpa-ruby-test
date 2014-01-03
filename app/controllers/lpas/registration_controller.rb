class Lpas::RegistrationController < ApplicationController
  before_filter :check_applicant
  include Wicked::Wizard

  steps :start, :applicant, :correspondent, :signature_dates, :notice_date, :further_info, :fees

  def show
    begin
      @lpa = Lpa.find(params[:lpa_id])
    rescue ActiveResource::ForbiddenAccess
      render text: 'Forbidden', status: 403, layout: false
      return
    end
    case step
    when :notice_date
      skip_step if @lpa.people_to_be_told.empty?
    end
    render_wizard
  end

  def update
    @lpa = Lpa.find(params[:lpa_id])
    render_wizard @lpa
  end

  private
  def check_applicant
    @applicant = Applicant.current_applicant
    redirect_to new_applicant_path unless @applicant
  end
end
