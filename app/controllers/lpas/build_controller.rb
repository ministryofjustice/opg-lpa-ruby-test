class Lpas::BuildController < ApplicationController
  before_filter :check_applicant
  include Wicked::Wizard

  steps :type, :donor, :when_to_use, :life_sustaining, :attorneys, :how_attorneys_act, :replacement_attorneys, :how_replacement_attorneys_act, :certificate_provider, :people_to_be_told, :certificate_provider2, :review

  def show
    @lpa = Lpa.find(params[:lpa_id])
    case step
    when :when_to_use
      skip_step if @lpa.type == "Health and welfare"
    when :life_sustaining
      skip_step if @lpa.type == "Property and financial affairs"
    when :donor
      @lpa.donor = @lpa.donor || Donor.new
    when :certificate_provider
      @lpa.certificate_provider = @lpa.certificate_provider || CertificateProvider.new
    when :certificate_provider2
      if @lpa.people_to_be_told.present?
        skip_step
      else
        @lpa.certificate_provider2 = @lpa.certificate_provider2 || CertificateProvider.new
      end
    when :how_attorneys_act
      skip_step if @lpa.attorneys.size <= 1
    when :how_replacement_attorneys_act
      skip_step if @lpa.replacement_attorneys.size <= 1
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
