class Lpas::RegistrationController < ApplicationController
  # before_filter :check_applicant
  include Wicked::Wizard

  steps :start, :applicant, :correspondent, :signature_dates, :notice_date, :further_info,
        :payment

  def show
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:lpa_id])
      render_wizard
    end
  end

  def update
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:lpa_id])
      render_wizard @lpa
    end
  end
end
