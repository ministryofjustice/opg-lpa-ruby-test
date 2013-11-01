class PeopleToBeToldController < ApplicationController

  def new
    @lpa = Lpa.find(params[:lpa_id])
    @person_to_be_told = PersonToBeTold.new
  end

  def create
    @lpa = Lpa.find(params[:lpa_id])
    @person_to_be_told = PersonToBeTold.new(params[:person_to_be_told])
    @lpa.people_to_be_told << @person_to_be_told

    if @lpa.save
      redirect_to lpa_build_path(lpa_id: @lpa, id: :people_to_be_told)
    else
      render template: "/people_to_be_told/new"
    end
  end

end
