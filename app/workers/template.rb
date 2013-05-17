class Template
    include Sidekiq::Worker
    sidekiq_options :retry => 2
	def perform(user_id, venue_id)

	end
end
