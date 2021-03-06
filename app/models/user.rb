class User < ActiveRecord::Base
	rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :picture

  has_many :services, :dependent => :destroy
  has_many :posts
  has_attached_file :picture, styles: {
  	tiny: '50x50',
    thumb: '100x100',
    square: '128x128'
  }

  def self.guest_account_available?
    if self.find_by_username('guest') == nil
      return false
    else
      return true
    end
  end

  def self.create_guest_account
    self.new(:email => 'guest@jalinsuara.com', :username => 'guest', :password => 'j4l1nsu4r4', :password_confirmation => 'j4l1nsu4r4').save!
  end

  def self.get_guest_account
    return self.find_by_username('guest')
  end

  def get_number_of_stories
    Post.count(:conditions => "user_id = #{self.id}")
  end

  def get_number_of_comments
    Comment.count(:conditions => "owner_id = #{self.id}")
  end

  # def password_required?
  #   super && provider.blank?
  # end

	# def self.new_with_session(params, session)
	#   if session["devise.user_attributes"]
	#     new(session["devise.user_attributes"], without_protection: true) do |user|
	#       user.attributes = params
	#       user.valid?
	#     end
	#   else
	#     super
	#   end    
	# end

	# # def username_required?
	# #   super && provider.blank?
	# # end

	# # def email_required?
	# #   super && provider.blank?
	# # end

	# def update_with_password(params, *options)
	#   if encrypted_password.blank?
	#     update_attributes(params, *options)
	#   else
	#     super
	#   end
	# end
end
