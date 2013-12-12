class ApplicantsController < ApplicationController

  before_filter :redirect_to_root_if_not_signed_in

  def new
    if Applicant.current_applicant
      redirect_to lpas_path
    else
      @applicant = Applicant.new
    end
  end

  def create
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      store_applicant_name(@applicant)

      redirect_to lpas_path
    else
      render :template => '/applicants/new'
    end
  end

  private

  def applicant_params
    create_single_date_field :applicant
    params[:applicant]
  end

  def redirect_to_root_if_not_signed_in
    redirect_to '/' unless @signed_in
  end

end
