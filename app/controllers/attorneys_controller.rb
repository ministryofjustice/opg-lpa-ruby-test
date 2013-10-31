class AttorneysController < ApplicationController

  def new
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new
  end

  def create
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new(params[:attorney])
    @lpa.send(attorney_relation) << @attorney

    if @lpa.save
      redirect_to lpa_build_path(lpa_id: @lpa, id: attorney_relation)
    else
      render template: "/#{attorney_relation}/new"
    end
  end

  def attorney_relation
    :attorneys
  end

end
