class ApiController < ApplicationController

	def template
		Cupon.cupon_from_template(params)
		render :status =>200, :json=> {:status => "Success"}
	end

	#curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"cupon_id":"cc2ee3574d3204a06f8620206f6a698f54dfb1f6e902e756e9e135481af9ad64", "friends":["paco","jorge","antonio"]}' http://localhost:3000/api/share.json
	def share
		respond = Cupon.cupon_from_cupon(params[:cupon_id], params[:friends])
		render :status =>200, :json=> {:status => respond}
	end

#curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"user_id":"4132443"}' http://localhost:3000/api/getcupons.json
  def getcupons
    respond_to do |format|
      format.json { render :status => 200, :json => Cupon.getCupons(params[:user_id])}
    end
  end

end
