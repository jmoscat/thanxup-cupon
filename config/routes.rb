ThanxupCupon::Application.routes.draw do
  match '/cupon/:cupon_id' => 'cupon#show'
  match '/cupon/redeem/:cupon_id' => 'cupon#redeem'


  match '/api/getcupons' => 'api#getcupons'
  match '/api/template' => 'api#template'
  match '/api/share' => 'api#share'
end
