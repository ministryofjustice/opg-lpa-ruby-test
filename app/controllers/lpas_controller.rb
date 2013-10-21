class LpasController < ApplicationController
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
