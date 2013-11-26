class PeopleToBeToldController < ApplicationController

  def new
    with_secure_token(Lpa) do
      @lpa = Lpa.find(params[:lpa_id])
      @person_to_be_told = PersonToBeTold.new
    end
  end

  def create
    with_secure_token(Lpa) do
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

end
