class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end
  def create
    @applicant = Applicant.new(params[:applicant])
    if @applicant.save
      session[:applicant_id] = @applicant.id
      redirect_to lpas_path
    else
      render :template => '/applicants/new'
    end
  end
end
