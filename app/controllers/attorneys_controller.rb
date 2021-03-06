class AttorneysController < ApplicationController

  def new
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new

    render :layout => !request.xhr?
  end

  def create
    @lpa = Lpa.find(params[:lpa_id])
    @attorney = Attorney.new(attorney_params)
    @lpa.send(attorney_relation) << @attorney


    if @lpa.save
      respond_to do |format|
        format.html { redirect_to lpa_build_path(lpa_id: @lpa, id: attorney_relation) }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { render template: "/#{attorney_relation}/new" }
        format.json { render json: { errors: @attorney.errors } }
      end        
    end
  end

  def destroy
    @lpa = Lpa.find(params[:lpa_id])

    if attorney = @lpa.attorneys.detect {|x| x.id == params[:id]}
      attorney._destroy = true
    end
    if replacement_attorney = @lpa.replacement_attorneys.detect {|x| x.id == params[:id]}
      replacement_attorney._destroy = true
    end

    @lpa.save

    @lpa = Lpa.find(params[:lpa_id])
    redirect_to lpa_build_path(lpa_id: @lpa, id: attorney_relation)
  end

  def attorney_relation
    :attorneys
  end

  private

  def attorney_params
    create_single_date_field :attorney
    params[:attorney]
  end

end
