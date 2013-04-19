ThanxupCupon::Application.routes.draw do
  match '/cupon/:cupon_id' => 'cupon#show'
  match '/cupon/redeem/:cupon_id' => 'cupon#redeem'
end
