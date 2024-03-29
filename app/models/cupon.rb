  #cupon
require 'rest_client'
require 'json'

class Cupon
  include Mongoid::Document
  include Mongoid::Timestamps
  field :store_id, type: String
  field :cupon_id, type: String
  field :user_fb_id, type: String
  field :qr, type: String
  field :parent_cupon, type: String

  field :user_name, type: String
  field :venue_name, type: String
  field :venue_pass, type: String
  field :venue_kind, type: String
  field :venue_address, type: String

# Cupon info
	field :cupon_text, type: String
	field :valid_from, type: DateTime
  field :valid_until, type: DateTime
  field :used, type: Boolean,  default: false
  field :used_date, type: DateTime

#
  field :kind, type: String #IND, SHA

# Sharable information
  field :social_redeem, type: Boolean,  default: false
  field :social_text, type: String
  field :social_count, type: Integer, default: 0
  field :social_limit, type: Integer
  field :social_offer, type: String #deprecated
  field :social_from, type: DateTime
  field :social_until, type: DateTime
  field :shared_date, type: DateTime

  validates_uniqueness_of :cupon_id
  index({user_fb_id: 1})
  index({ cupon_id: 1}, { unique: true })

  def self.cupon_from_template(params)
    #template,user_id, venue_id
    uid = params["user_id"]
    new_cupon = Cupon.new
    new_cupon.cupon_id = secure_hash( "#{new_cupon._id}"+"#{uid}"+ DateTime.now.to_s)
    new_cupon.store_id = params["venue_id"]
    new_cupon.user_fb_id = uid
    new_cupon.parent_cupon = ""
    new_cupon.user_name = params["user_name"]
    new_cupon.venue_name = params["venue_name"]
    new_cupon.venue_pass = params["venue_pass"]
    new_cupon.used = false
    new_cupon.social_redeem = false
    new_cupon.cupon_text = params["cupon_text"]
    new_cupon.valid_from = params["valid_from"]
    new_cupon.valid_until = params["valid_until"]
    new_cupon.venue_kind = params["venue_kind"]
    new_cupon.venue_address = params["venue_address"]

    new_cupon.kind = params["kind"]
    new_cupon.social_text = params["social_text"]
    new_cupon.social_count = params["social_count"]
    new_cupon.social_limit = params["social_limit"]
    new_cupon.social_from  = params["social_from"]
    new_cupon.social_until  = params["social_until"]
    new_cupon.save
    Cupon.notify_cupon(uid)
  end

#First method call to create a cupon for list of friends
  def self.cupon_from_cupon(cupon_id, friends)
    father_cupon = Cupon.find_by(cupon_id: cupon_id)
    if father_cupon.social_limit <= father_cupon.social_count
      return "Ya has compartido..."
    elsif friends.empty?
      return "Sorry...no has seleccionado amigos :("
    elsif (friends.size < 3)
      return "Has seleccionado a menos de 3 amigos..."
    elsif Cupon.validate_date(father_cupon.valid_from, father_cupon.valid_until)
      CuponFriends.perform_async(cupon_id, friends)
      father_cupon.shared_date = Date.today
      return "Compartido!"
    else
      return "Este cupon esta caducado..."
    end
  end

  def self.cupon_friends(cupon_id,friends)
    father_cupon = Cupon.find_by(cupon_id: cupon_id)
    father_cupon.shared_date = Time.now.utc
    cupons = []
    if !friends.empty? #Check if friends is empty
      friends.each do |id|
        name = RestClient.get "http://graph.facebook.com/"+"#{id}"+"?fields=name", :content_type => :json, :accept => :json
        if !name.nil? #If user doesn't exist....
          new_cupon = Cupon.create(
            :store_id => father_cupon.store_id,
            :cupon_id => Cupon.secure_hash("#{id}"+ DateTime.now.to_s),
            :user_fb_id => id,
            :user_name => JSON.parse(name)["name"],
            :venue_pass => father_cupon.venue_pass,
            :venue_name =>father_cupon.venue_name,
            :venue_kind => father_cupon.venue_kind,
            :social_redeem => false, 
            :parent_cupon => father_cupon.cupon_id,
            :venue_address => father_cupon.venue_address,
            :cupon_text => father_cupon.cupon_text,
            :valid_from => father_cupon.valid_from,
            :valid_until => father_cupon.valid_until,
            :used => false,
            :kind => "IND"
            ) 
          cupons << new_cupon.cupon_id
          #Notificaciones api y iphone (sin worker), check if on ThanxUp
          Cupon.cupon_share_notify(cupons, friends, father_cupon.user_fb_id,father_cupon.store_id)
        end
      end
      if (father_cupon.kind == "SHA") && (father_cupon.social_redeem == false)
        father_cupon.social_count = father_cupon.social_count + cupons.count
        father_cupon.save
        Cupon.weekly_notify(father_cupon.user_fb_id, 1, cupons.count)
        if (father_cupon.social_count >= father_cupon.social_limit)
          father_cupon.social_redeem = true
          father_cupon.save
          Cupon.new_social_cupon(father_cupon.cupon_id) #OLD:SocialCupon.perform_async(father_cupon.cupon_id) #
        end
      end
    end
  end



  def self.new_social_cupon(cupon_id)
    father_cupon = Cupon.find_by(cupon_id: cupon_id)
    user_id = father_cupon.user_fb_id
    Cupon.create(
        :store_id => father_cupon.store_id,
        :cupon_id => secure_hash("#{user_id}"+ DateTime.now.to_s),
        :user_fb_id => user_id,
        :venue_name => father_cupon.venue_name,
        :user_name => father_cupon.user_name,
        :venue_pass => father_cupon.venue_pass,
        :venue_address => father_cupon.venue_address,
        :parent_cupon => "",
        :venue_kind => father_cupon.venue_kind,
        :cupon_text => father_cupon.social_text,
        :valid_from => father_cupon.social_from,
        :valid_until => father_cupon.social_until,
        :used => false,
        :kind => "IND"
        )   
    Cupon.notify_cupon(user_id)
  end
  def self.getCupons(user_id, update_stamp_str)
    update_stamp = Time.parse(update_stamp_str)
    return Cupon.where(user_fb_id: user_id, used: false, :created_at.gte => update_stamp).to_json(:only => [ :cupon_id, :store_id, :venue_name ,:cupon_text, :venue_address, :venue_kind ,:valid_from, :valid_until, :kind, :used ,:social_text ])
  end

  def self.getUsedCupons (user_id, update_stamp_str)
    update_stamp = Time.parse(update_stamp_str)
    used = Cupon.only(:cupon_id).where(user_fb_id: user_id, used: true, :used_date.gte =>update_stamp)
    respon = "["

    used.each do |x|
      respon = respon + "\'"+x.cupon_id + "\',"
    end
    respon = respon[0..-2] + "]"
    return respon
  end


  def self.secure_hash (string)
    Digest::SHA2.hexdigest(string)
  end

  def self.validate_date(from, till)
    if (DateTime.now.utc >= from) and (DateTime.now.utc <= till)
      return true
    else
      return false
    end
  end

  def self.redeem(cupon_id)
    cupon = Cupon.find_by(cupon_id: cupon_id)
    cupon.used = true
    cupon.used_date = Time.now.utc
    cupon.save
    father_cupon = Cupon.find_by(cupon_id: cupon.parent_cupon)
    if (father_cupon.kind != "IND")
      Cupon.weekly_notify(father_cupon.user_fb_id, 2, 1)
    end

  # CUANDO TENGAMOS CONSUMIBLES...
  #  father_cupon = Cupon.find_by(cupon_id: cupon.parent_cupon)
  #  if (father_cupon.kind == "CONS") && (father_cupon.social_redeem == false)
  #    father_cupon.social_count = father_cupon.social_count + 1
  #    father_cupon.save
  #    Cupon.weekly_notify(father_cupon.user_fb_id, 2, 1)
  #    if (father_cupon.social_count >= father_cupon.social_limit)
  #      father_cupon.social_redeem = true
  #      father_cupon.save
  #      Cupon.new_social_cupon(father_cupon.cupon_id)
  #     #notify user
  #    end
  #  end
  end

  def self.weekly_notify(user_id, call_type, count)
    url_base = Cupon.getURL_env
    if call_type == 1
      url = url_base + "/back/addshare"
      respond = RestClient.post url, {:user_id => user_id, :count => count }.to_json, :content_type => :json, :accept => :json
    elsif call_type == 2
      url = url_base + "/back/addconsume"
      respond = RestClient.post url, {:user_id => user_id, :count => count }.to_json, :content_type => :json, :accept => :json
    end
  end

  def self.cupon_share_notify(cupon_ids, friends, user_id, venue_id)
    url_base = Cupon.getURL_env
    url = url_base + "/back/socialnotify"
    respond = RestClient.post url, {:cupons => cupon_ids, :friends => friends, :user_id => user_id, :venue_id => venue_id}.to_json, :content_type => :json, :accept => :json
  end

  def self.notify_cupon(user_id)
    url_base = Cupon.getURL_env
    url = url_base + "/back/notifycupon"
    respond = RestClient.post url, {:user_id => user_id}.to_json, :content_type => :json, :accept => :json
  end
  def self.getURL_env
    if Rails.env.development?
      return ENV["DEV_API"]
    elsif Rails.env.production?
      return ENV["PROD_API"]
    end
  end

end
