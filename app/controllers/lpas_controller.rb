class LpasController < ApplicationController
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
end
