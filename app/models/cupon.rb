class Cupon
  include Mongoid::Document
  include Mongoid::Timestamps
  field :store_id, type: String
  field :user_fb_id, type: String
  field :parent_cupon, type: String
# Cupon info
	field :cupon_text, type: String
	field :valid_from, type: DateTime
  field :valid_until, type: DateTime
  field :used, type: Boolean

#
  field :kind, type: String 

# Sharable information
  field :social_text, type: String
  field :social_count, type: Integer, default: ""
  field :social_limit, type: Integer
  field :social_offer, type: String
  field :social_from, type: Date
  field :social_until, type: Date

  
  index({user_fb_id: 1})
  index({ _id: 1}, { unique: true })


  def self.cupon_from_template(template,user_id, venue_id)
    new_cupon = Cupon.new
    new_cupon.store_id = venue_id
    new_cupon.user_fb_id = user_id
    new_cupon.parent_cupon = ""
    new_cupon.used = false
    new_cupon.cupon_text = template.cupon_text
    new_cupon.valid_from = template.valid_from
    new_cupon.valid_until = template.valid_until

    new_cupon.kind = template.kind
    new_cupon.sharable_text = template.social_text
    new_cupon.shared_count = template.social_count
    new_cupon.sharable_limit = template.social_limit
    new_cupon.social_from  = template.social_from
    new_cupon.social_until  = template.social_until
    new_cupon.save
  end

  def self.getCupons(user_id)
    return Cupon.where(user_fb_id: user_id, used: false).to_json(:only => [ :_id, :store_id, :cupon_text, :valid_from, :valid_until, :kind ])
  end


end
