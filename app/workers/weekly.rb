class Weekly
    include Sidekiq::Worker
    sidekiq_options :retry => 1
	def perform(user_id, call_type, count)
		Cupon.weekly_notify(user_id, call_type, count)
	end
end
