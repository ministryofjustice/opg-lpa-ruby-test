class PeopleToBeToldController < ApplicationController

  def new
    @lpa = Lpa.find(params[:lpa_id])
    @person_to_be_told = PersonToBeTold.new

    render :layout => !request.xhr?
  end

  def create
    @lpa = Lpa.find(params[:lpa_id])
    @person_to_be_told = PersonToBeTold.new(params[:person_to_be_told])
    @lpa.people_to_be_told << @person_to_be_told

    if @lpa.save
      respond_to do |format|
        format.html { redirect_to lpa_build_path(lpa_id: @lpa, id: :people_to_be_told) }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { render template: "/people_to_be_told/new" }
        format.json { render json: { errors: @person_to_be_told.errors } }
      end
    end
  end

end
