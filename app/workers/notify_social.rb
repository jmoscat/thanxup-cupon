class NotifySocial
    include Sidekiq::Worker
    sidekiq_options :retry => 1
	def perform(cupons, friends, user_id, venue_id)
		Cupon.cupon_share_notify(cupons, friends, user_id, venue_id)
	end
end