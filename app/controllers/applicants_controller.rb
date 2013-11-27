class ApplicantsController < ApplicationController

  def new
    @applicant = Applicant.new
  end

  def create
    with_secure_token(Applicant) do
      @applicant = Applicant.new(applicant_params)

      if @applicant.save
        session[:applicant_id] = @applicant.id
        redirect_to lpas_path
      else
        render :template => '/applicants/new'
      end
    end
  end

  def delete
    session[:applicant_id] = nil
    redirect_to "/"
  end

  private

  def applicant_params
    create_single_date_field :applicant
    params[:applicant]
  end

end
