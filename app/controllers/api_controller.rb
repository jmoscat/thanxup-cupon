class ApiController < ApplicationController
skip_before_filter :verify_authenticity_token
#respond = RestClient.post "http://localhost:3000/api/template", {:user_name => "jorge", :venue_name => "paco", :venue_pass => "123" ,:user_id => "123432", :venue_id => "121231", :cupon_text => "Lorem ipsum", :valid_from => "Sat, 18 May 2013 09:17:57 -0700", :valid_until => "Tue, 21 May 2013 09:17:57 -0700", :kind => "SHA", :social_text => "Lorem ipsum social", :social_count => 0, :social_limit => 3, :social_from => "Sat, 18 May 2013 09:17:57 -0700", :social_until => "Tue, 21 May 2013 09:17:57 -0700"}.to_json, :content_type => :json, :accept => :json
def template
	#Template.perform_async(params)
	Cupon.cupon_from_template(params)
	render :status =>200, :json=> {:status => "Success"}
end

#curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"cupon_id":"9b8e1d1cdb35f5c017f9bc20d074a5d919a102386b2a5e7bad53b76f6ddd82ae", "friends":["1220884986","1484984030"]}' http://localhost:3000/api/share.json
def share
	respond = Cupon.cupon_from_cupon(params[:cupon_id], params[:friends])
	render :status =>200, :json=> {:status => respond}
end

#curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d '{"user_id":"545887286", "update_stamp":"2012-08-13 06:25:36 UTC"}' http://coupon.thanxup.com/api/getcupons.json
  def getcupons
    respond_to do |format|
      format.json { render :status => 200, :json => {:cupons =>Cupon.getCupons(params[:user_id],params[:update_stamp]), :used => Cupon.getUsedCupons(params[:user_id],params[:update_stamp]), :update_stamp => Time.now.utc.to_s }}
    end
  end

end
