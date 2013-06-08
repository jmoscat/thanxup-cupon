class CuponController < ApplicationController

	def show
    @cupon = Cupon.find_by(cupon_id: params[:cupon_id])
    date_from = @cupon.valid_from.strftime("%d/%m/%Y")
    date_until = @cupon.valid_until.strftime("%d/%m/%Y")
    @date = date_from + " - " +date_until
    @redeem = "http://www.coupon.thanxup.com/cupon/redeem/"+params[:cupon_id]
  end

  def redeem
    @cupon = Cupon.find_by(cupon_id: params[:cupon_id])
  end

  def check
    passcode = params[:passcode]
    cupon = Cupon.find_by(cupon_id: params[:cupon_id])
    if cupon.nil?
      redirect_to :back, :alert => "Este cupon no existe :("
    elsif (passcode != cupon.venue_pass)
      redirect_to :back, :alert => "Passcode invalido... :("
    elsif Cupon.validate_date(cupon.valid_from, cupon.valid_until) == false
      redirect_to :back, :alert => "Fuera de fecha de caducidad... :() "
    elsif (cupon.used == true)
      redirect_to :back, :alert => "Cupon usado :("
    else
      Redeem.perform_async(params[:cupon_id])
      redirect_to :back, :notice => "Todo en orden!! :)"
    end
  end
end
