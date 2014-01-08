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
    @lpa.update_attributes( lpa_params )
    render_wizard @lpa
  end

  private
  def check_applicant
    @applicant = Applicant.current_applicant
    redirect_to new_applicant_path unless @applicant
  end

  def lpa_params
    set_registration_applicants
    params[:lpa]
  end

  def set_registration_applicants
    if params[:lpa] && params[:lpa][:registration_applicants]
      if params[:lpa][:registration_applicants] == "donor"
        params[:lpa][:registration_applicants] = {type: "donor", ids: []}
      elsif params[:lpa][:registration_applicants] == "attorneys"
        params[:lpa][:registration_applicants] = {type: "attorneys", ids: []}
        @lpa.attorneys.each_with_index do |attorney, index|
          if params["registration_applicants_attorney-#{index}".to_sym]
            params[:lpa][:registration_applicants][:ids] << attorney.id
          end
        end
      end
    end
  end
end
