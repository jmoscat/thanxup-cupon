class ApiController < ApplicationController
 respond_to :json
	def template
		Cupon.cupon_from_template(params)
		render :status =>200, :json=> {:status => "Success"}
	end

	def share
		Cupon.cupon_from_cupon(params[:cupon_id], params[:friends])
		render :status =>200, :json=> {:status => "Success"}
	end

end
