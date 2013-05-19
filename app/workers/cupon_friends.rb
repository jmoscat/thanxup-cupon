class CuponFriends
    include Sidekiq::Worker
    sidekiq_options :retry => 2
	def perform(cupon_id, friends)
		Cupon.cupon_friends(cupon_id, friends)
	end
end