class AttorneysController < ApplicationController
  def new
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new
  end
  def create
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new(params[:attorney])
    @lpa.attorneys << @attorney
    @lpa.save
    redirect_to lpa_build_path(:lpa_id => @lpa, :id => :attorneys)
  end
end
