class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :picture, :uid, :provider

  has_many :posts

  has_attached_file :picture,
    styles: {
    	tiny: '50x50',
      thumb: '100x100',
      square: '128x128'
    }

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
	  user = User.where(:provider => auth.provider, :uid => auth.uid).first
	  unless user
	    user = User.create(username:auth.extra.raw_info.name,
	    	provider:auth.provider,
	    	uid:auth.uid,
	    	email:auth.info.email,
	    	password:Devise.friendly_token[0,20]
	    )
	  end
	  user
	end

	def self.from_omniauth(auth)
	  where(auth.slice(:provider, :uid)).first_or_create do |user|
	    user.provider = auth.provider
	    user.uid = auth.uid
	    user.username = auth.info.nickname
	  end
	end

	def self.new_with_session(params, session)
	  if session["devise.user_attributes"]
	    new(session["devise.user_attributes"], without_protection: true) do |user|
	      user.attributes = params
	      user.valid?
	    end
	  else
	    super
	  end    
	end

	# def username_required?
	#   super && provider.blank?
	# end

	def password_required?
	  super && provider.blank?
	end

	# def email_required?
	#   super && provider.blank?
	# end

	def update_with_password(params, *options)
	  if encrypted_password.blank?
	    update_attributes(params, *options)
	  else
	    super
	  end
	end
end
