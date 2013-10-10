class SocialCupon
    include Sidekiq::Worker
    sidekiq_options :retry => 2
	def perform(cupon_id)
		Cupon.new_social_cupon(cupon_id)
	end
end