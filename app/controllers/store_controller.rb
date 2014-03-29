class StoreController < ApplicationController
  #curl -v -H "Accept: application/json" -H "Content-type: application/json" -X GET http://192.168.1.103:3000/getapp.json
  def getapp
    if request.user_agent =~ /iPod|iPad|iPhone/i
  	  redirect_to "https://itunes.apple.com/uy/app/thanxup/id764549346?mt=8"
    elsif request.user_agent =~ /iAndroid/i
      redirect_to "https://play.google.com/store/apps/details?id=com.thanxup.android.app"
    else
      redirect_to "http://thanxup.com"
    end
  end

end
