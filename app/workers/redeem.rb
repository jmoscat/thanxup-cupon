class Redeem
    include Sidekiq::Worker
    sidekiq_options :retry => 2
	def perform(cupon)
		cupon.redeem
	end
end