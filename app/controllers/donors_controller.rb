class DonorsController < ApplicationController
  before_filter :check_applicant
  def new
    puts "============= new donor ==============="
    @lpa = Lpa.find(params[:lpa_id])
    @donor = Donor.new
    render :layout => !request.xhr?
  end

  def create
    @lpa = Lpa.find(params[:lpa_id])
    @donor = Donor.new(donor_params)
    @lpa.donor = @donor

    if @lpa.save
      puts "============== Saved new donor ==========="
      respond_to do |format|
        format.html { redirect_to lpa_build_path(lpa_id: @lpa, id: :donor) }
        format.json { render json: {success: true } }
      end
    else
      puts "============== Couldnt Save new donor ==========="
      puts  @lpa.errors.inspect
      respond_to do |format|
        format.html { render template: "/donors/new" }
        format.json { render json: {errors: @lpa.errors } }
      end        
    end
  end

  def edit
    @lpa = Lpa.find(params[:lpa_id])
    @donor = @lpa.donor
    render :layout => !request.xhr?
  end

  private
  def donor_params
    create_single_date_field :donor
    params[:donor]
  end

  def check_applicant
    @applicant = Applicant.current_applicant
    redirect_to new_applicant_path unless @applicant
  end
end
