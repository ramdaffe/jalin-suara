class Service < ActiveRecord::Base
  attr_accessible :provider, :uemail, :uid, :uname
  belongs_to :user
end
