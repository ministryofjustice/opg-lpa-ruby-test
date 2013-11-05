class AttorneysController < ApplicationController

  def new
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new
  end

  def create
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new(attorney_params)
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

  private

  def attorney_params
    create_single_date_field :attorney
    params[:attorney]
  end

  def create_single_date_field model_name
    if params[model_name]
      params[model_name] = MultiparameterAttributesHandler.manipulate_all params[model_name]
      params[model_name].each {|key, value| params[model_name].delete(key) if key[/\(\di\)/] }
    end
  end
end
