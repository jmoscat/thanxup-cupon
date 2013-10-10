class Redeem
    include Sidekiq::Worker
    sidekiq_options :retry => 2
	def perform(cupon_id)
		Cupon.redeem(cupon_id)
	end
end