class Lpas::BuildController < ApplicationController
  before_filter :check_applicant
  include Wicked::Wizard

  steps :type, :donor, :when_to_use, :life_sustaining, :attorneys, :how_attorneys_act, :replacement_attorneys, :how_replacement_attorneys_act, :certificate_provider, :people_to_be_told, :certificate_provider2, :review, :complete

  def show
    begin
      @lpa = Lpa.find(params[:lpa_id])
    rescue ActiveResource::ForbiddenAccess
      render text: 'Forbidden', status: 403, layout: false
      return
    end
    @lpa.donor.date_of_birth = Date.parse(@lpa.donor.date_of_birth) if @lpa.donor.present? && @lpa.donor.date_of_birth.present?
    case step
    when :when_to_use
      skip_step if @lpa.type == "Health and welfare"
    when :life_sustaining
      skip_step if @lpa.type == "Property and financial affairs"
    when :donor
      @lpa.donor = @lpa.donor || Donor.new
      @lpa.donor.date_of_birth = nil if @lpa.donor.date_of_birth.blank?
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
    @lpa.update_attributes( lpa_params )
    render_wizard @lpa
  end

  private
  def check_applicant
    # redirect_to new_applicant_path unless Applicant.current_applicant
    @applicant = Applicant.current_applicant
    redirect_to new_applicant_path unless @applicant    
  end

  def lpa_params
    create_single_date_field :donor
    params[:lpa]
  end

  def create_single_date_field model_name
    if params[:lpa][model_name]
      params[:lpa][model_name] = MultiparameterAttributesHandler.manipulate_all params[:lpa][model_name]
      params[:lpa][model_name].each {|key, value| params[:lpa][model_name].delete(key) if key[/\(\di\)/] }
    end
  end
end
