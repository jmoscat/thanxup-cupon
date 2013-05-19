class NotifySocial
    include Sidekiq::Worker
    sidekiq_options :retry => 1
	def perform(cupon_id)
		Cupon.cupon_share_notify(cupons, friends, user_id)
	end
end