class Cupon
  include Mongoid::Document
  include Mongoid::Timestamps
  field :store_id, type: String
  field :cupon_id, type: String
  field :user_fb_id, type: String
  field :qr, type: String
  field :parent_cupon, type: String
# Cupon info
	field :cupon_text, type: String
	field :valid_from, type: DateTime
  field :valid_until, type: DateTime
  field :used, type: Boolean,  default: false

#
  field :kind, type: String 

# Sharable information
  field :social_text, type: String
  field :social_count, type: Integer, default: 0
  field :social_limit, type: Integer
  field :social_offer, type: String
  field :social_from, type: Date
  field :social_until, type: Date

  
  index({user_fb_id: 1})
  index({ _id: 1}, { unique: true })

  def self.cupon_from_template(params)
    #template,user_id, venue_id
    uid = params[:user_id]
    new_cupon = Cupon.new
    new_cupon.cupon_id = secure_hash( "#{new_cupon._id}"+"#{uid}"+ DateTime.now.to_s)
    new_cupon.store_id = params[:venue_id]
    new_cupon.user_fb_id = uid
    new_cupon.parent_cupon = ""
    new_cupon.used = false
    new_cupon.cupon_text = params[:cupon_text]
    new_cupon.valid_from = params[:valid_from]
    new_cupon.valid_until = params[:valid_until]

    new_cupon.kind = params[:kind]
    new_cupon.social_text = params[:social_text]
    new_cupon.social_count = params[:social_count]
    new_cupon.social_limit = params[:social_limit]
    new_cupon.social_from  = params[:social_from]
    new_cupon.social_until  = params[:social_until]
    new_cupon.save
  end

  def self.cupon_from_cupon(cupon_id, friends)
    father_cupon = Cupon.find_by(cupon_id: cupon_id)
    if father_cupon.social_limit <= father_cupon.social_count
      return "Already shared"
    elsif Cupon.validate_date(father_cupon.valid_from, father_cupon.valid_until)
      friends.each do |id|
        Cupon.create(
          :store_id => father_cupon.store_id,
          :cupon_id => Cupon.secure_hash("#{id}"+ DateTime.now.to_s),
          :user_fb_id => id,
          :parent_cupon => father_cupon.cupon_id,
          :cupon_text => father_cupon.cupon_text,
          :valid_from => father_cupon.valid_from,
          :valid_until => father_cupon.valid_until,
          :used => false,
          :kind => "IND"
          ) 
        end
        if (father_cupon.kind == "SHA")
          father_cupon.social_count = father_cupon.social_count + friends.size
          father_cupon.save
          if (father_cupon.social_count >= father_cupon.social_limit)
            Cupon.new_social_cupon(father_cupon.cupon_id)
          end
        end
        return "Sucess"
    else
      return "Expired"
    end
  end

  def self.new_social_cupon(cupon_id)
    father_cupon = Cupon.find_by(cupon_id: cupon_id)
    user_id = father_cupon.user_fb_id
    Cupon.create(
        :store_id => father_cupon.store_id,
        :cupon_id => secure_hash("#{user_id}"+ DateTime.now.to_s),
        :user_fb_id => user_id,
        :parent_cupon => "",
        :cupon_text => father_cupon.social_text,
        :valid_from => father_cupon.social_from,
        :valid_until => father_cupon.social_until,
        :used => false,
        :kind => "IND"
        ) 
    
  end

  def self.getCupons(user_id)
    return Cupon.where(user_fb_id: user_id, used: false).to_json(:only => [ :cupon_id, :store_id, :cupon_text, :valid_from, :valid_until, :kind ])
  end

  def self.secure_hash (string)
    Digest::SHA2.hexdigest(string)
  end

  def self.validate_date(from, till)
    if (DateTime.now>= from) and (DateTime.now <= till)
      return true
    else
      return false
    end
  end

  def redeem
    self.used = true
    father_cupon = Cupon.find_by(cupon_id: cupon_id)
    if (father_cupon != nil) && father_cupon.kind == "CONS"
      father_cupon.social_count = father_cupon.social_count
      if (father_cupon.social_count >= father_cupon.social_limit)
        Cupon.new_social_cupon(father_cupon.cupon_id)
        #notify user
      end
    end
  end

end
