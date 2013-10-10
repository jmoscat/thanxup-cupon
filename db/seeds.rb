# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cupon1 = Cupon.new(
	store_id:"121231",
	cupon_id: "0b5459ca1423672d69b33afe6284ADb5c134b64cd072d00f8a1994a9888a35012",
	cupon_text: "Este es un cupon con texto maaaaaazo de largo para que te vuelvas loco maquetando, si senhor!! oy yeah como molo",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "1220884986",
	venue_name: "Rixi House",
	used_date: "",
	used: false,
	kind: "SHA",
	social_text: "Nuevo cupon molon!!",
	social_count: 0,
	social_limit: 3,
	social_offer: "Oferta sh",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700",
	venue_pass: "123"
	)
cupon1.save

cupon1 = Cupon.new(
	store_id:"121231",
	cupon_id: "0b5459ca1423670d69b33afe62842DS5c1acb64c0232d00f8a1994a9888a95012",
	cupon_text: "Cupon copas",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "1220884986",
	used: false,
	used_date: "2013-09-08 20:07:18 UTC",
	kind: "SHA",
	social_text: "Nuevo cupon molon!!",
	social_count: 0,
	social_limit: 3,
	social_offer: "Oferta sh",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700",
	venue_pass: "123"
	)
cupon1.save
cupon1 = Cupon.new(
	store_id:"121232",
	cupon_id: "0b5459ca1423670d69b33afe6Df15c1acb64c072d00f8a1994a9888a95012",
	cupon_text: "Cupon copas molas",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "545887286",
	used: false,
	used_date: "2013-09-08 19:07:39 UTC",
	kind: "SHA",
	social_text: "Nuevo cupon molon!!",
	social_count: 0,
	social_limit: 3,
	social_offer: "Oferta sh",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700",
	venue_pass: "123"
	)
cupon1.save

cupon1 = Cupon.new(
	store_id:"121232",
	cupon_id: "0b5459ca1423670d69b33afe6S3c1acb64c072d00f8a1994a9888a95012",
	cupon_text: "Cupon copas molas",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "545887286",
	used: false,
	used_date: "2013-09-08 20:07:39 UTC",
	kind: "SHA",
	social_text: "Nuevo cupon molon!!",
	social_count: 0,
	social_limit: 3,
	social_offer: "Oferta sh",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700",
	venue_pass: "123"
	)
cupon1.save


