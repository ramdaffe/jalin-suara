class Activity < ActiveRecord::Base
  attr_accessible :latitude, :longitude, :name, :picture, :description, :project_length, :project_area, :project_quantity, :blm_amount, :self_fund_amount, :male_proposal, :female_proposal, :male_beneficiary, :female_beneficiary, :poor_beneficiary, :subdistrict_id, :category_id
  acts_as_gmappable validation: false
  belongs_to :subdistrict
  belongs_to :category
  has_many :posts

  def get_subdistrict_name
    name = ''
    if self.subdistrict != nil
      name = self.subdistrict.name
    end

    return name
  end

  def get_category_name
    name = ''
    if self.category != nil
      name = self.category.name
    end

    return name
  end

  def gmaps4rails_address
	  "#{self.get_subdistrict_name} - #{self.name}" 
	end

  has_attached_file :picture, 
    :storage => :s3,
    :default_url => "/images/missing/:class_:attachment_:style.jpg", 
    :styles => {
    	tiny: '50x50',
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
    },
    :bucket => "qbl-paperclip",
    :s3_protocol => 'http',
    :s3_credentials => {
      :bucket => ENV['AWS_BUCKET'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
end