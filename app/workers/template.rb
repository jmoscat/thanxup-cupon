class Template
    include Sidekiq::Worker
    sidekiq_options :retry => 2
	def perform(params)
		Cupon.cupon_from_template(params)
	end
end
