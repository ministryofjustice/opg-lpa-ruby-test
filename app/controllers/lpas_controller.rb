class LpasController < ApplicationController
  before_filter :check_applicant
  def index
    
  end
  def find
    redirect_to edit_lpa_path(params[:lpa])
  end
  def edit
    @lpa = Lpa.new
  end
  def create
    @lpa = Lpa.new(params[:lpa])
    if @lpa.save
      render :text => "Success!"
    else
      render :template => 'lpas/edit'
    end
  end
  def update
    @lpa = Lpa.new(params[:lpa])
    if @lpa.save
      render :text => "Success!"
    else
      render :text => "Fail"
    end
  end
  private
  def check_applicant
    unless session[:applicant_id].present?
      redirect_to new_applicant_path
    end
  end
end
