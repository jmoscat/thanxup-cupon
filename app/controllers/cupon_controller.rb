class CuponController < ApplicationController

	def show
    @cupon = Discount.find(:first, :conditions => [ "hash_key = ?", params[:hash_key]])
    @redeem = "localhost:3000/redeem/"+@cupon.hash_key
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @redeem}
    end
  end

  def redeem
  	@cupon = Discount.find(:first, :conditions => [ "hash_key = ?", params[:hash_key]])
  	@client_password = Discount.where(:hash_key => params[:hash_key]).first.client.password
  end

  def getCupons
    respond_to do |format|
      format.json { render :status => 200, :json => Cupon.getCupons(params[:user_id])}
    end
  end


end
