class OmniauthCallbacksController < ApplicationController
	def all
    user = User.from_omniauth(request.env["omniauth.auth"])
	  if user.persisted?
	    sign_in_and_redirect user, notice: "Signed in!"
	  else
	    session["devise.user_attributes"] = user.attributes
	    redirect_to new_user_registration_url
	  end
  end
  alias_method :twitter, :all

	def password_required?
	  super && provider.blank?
	end

	 def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if user.persisted?
      sign_in_and_redirect user, :notice => "Signed in!"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end