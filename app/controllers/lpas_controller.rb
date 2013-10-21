class LpasController < ApplicationController
	def index
		
	end
	def find
		redirect_to edit_lpa_path(params[:lpa])
	end
	def edit
		@lpa = Lpa.new
	end
	def update
		@lpa = Lpa.new
		if @lpa.update(params[:lpa])
			render :text => "Success!"
		else
			render :text => "Fail"
		end
	end
end
