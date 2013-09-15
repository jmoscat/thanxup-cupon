# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

cupon1 = Cupon.new(
	store_id:"121231",
	cupon_id: "0b5459ca1423670d69b33afe62842afb5c134b64c072d00f8a1994a9888a95012",
	cupon_text: "Cupon domingo hoy!",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "1220884986",
	used_date: "",
	used: false,
	kind: "SHARABLE",
	social_text: "Comparte con 3 amigos y recibe una copa gratis!",
	social_count: 0,
	social_limit: 3,
	social_offer: "",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700"
	)
cupon1.save

cupon1 = Cupon.new(
	store_id:"121231",
	cupon_id: "0b5459ca1423670d69b33afe62842afb5c1acb64c0232d00f8a1994a9888a95012",
	cupon_text: "Cupon copas",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "1220884986",
	used: true,
	used_date: "2013-09-08 20:07:18 UTC",
	kind: "SHARABLE",
	social_text: "Comparte con 3 amigos y recibe una copa gratis!",
	social_count: 0,
	social_limit: 3,
	social_offer: "",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700"
	)
cupon1.save
cupon1 = Cupon.new(
	store_id:"121232",
	cupon_id: "0b5459ca1423670d69b33afe62842af15c1acb64c072d00f8a1994a9888a95012",
	cupon_text: "Cupon copas molas",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "545887286",
	used: true,
	used_date: "2013-09-08 19:07:39 UTC",
	kind: "SHARABLE",
	social_text: "Comparte con 3 amigos y recibe una copa gratis!",
	social_count: 0,
	social_limit: 3,
	social_offer: "",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700"
	)
cupon1.save

cupon1 = Cupon.new(
	store_id:"121232",
	cupon_id: "0b5459ca1423670d69b33afe62842af3c1acb64c072d00f8a1994a9888a95012",
	cupon_text: "Cupon copas molas",
	valid_from: "Sat, 18 May 2013 09:17:57 -0700",
	valid_until: "Tue, 21 May 2014 09:17:57 -0700",
	user_fb_id: "545887286",
	used: true,
	used_date: "2013-09-08 20:07:39 UTC",
	kind: "SHARABLE",
	social_text: "Comparte con 3 amigos y recibe una copa gratis!",
	social_count: 0,
	social_limit: 3,
	social_offer: "",
	social_from: "Sat, 18 May 2013 09:17:57 -0700",
	social_until:  "Tue, 21 May 2014 09:17:57 -0700"
	)
cupon1.save


