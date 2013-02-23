class ImplementerUnit < ActiveRecord::Base
  attr_accessible :name, :address, :phone, :facilitator, :facilitator_phone, :call_center, :picture, :subdistrict_id
  belongs_to :subdistrict

  has_attached_file :picture, :default_url => "/images/missing/:class_:attachment_:style.jpg", styles: {
  	tiny: '50x50',
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '400x400'
  }

  def get_subdistrict_name
    name = ''
    if self.subdistrict != nil
      name = self.subdistrict.name
    end

    return name
  end
end
