class ApiController < ApplicationController
skip_before_filter :verify_authenticity_token
#respond = RestClient.post "http://localhost:3000/api/template", {:user_name => "jorge", :venue_name => "paco", :venue_pass => "123" ,:user_id => "123432", :venue_id => "121231", :cupon_text => "Lorem ipsum", :valid_from => "Sat, 18 May 2013 09:17:57 -0700", :valid_until => "Tue, 21 May 2013 09:17:57 -0700", :kind => "SHA", :social_text => "Lorem ipsum social", :social_count => 0, :social_limit => 3, :social_from => "Sat, 18 May 2013 09:17:57 -0700", :social_until => "Tue, 21 May 2013 09:17:57 -0700"}.to_json, :content_type => :json, :accept => :json
	def template
		#Template.perform_async(params)
		Cupon.cupon_from_template(params)
		debugger
		render :status =>200, :json=> {:status => "Success"}
	end

	#curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"cupon_id":"98f97aed2e041e9d44fa76a4dd22b7ee2c6854bc1331be521e505d3c965703ff", "friends":["paco","jorge","antonio"]}' http://localhost:3000/api/share.json
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
