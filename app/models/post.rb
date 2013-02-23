class Post < ActiveRecord::Base
  attr_accessible :title, :activity_id, :description, :user_id, :picture
  belongs_to :activity
  belongs_to :user

  opinio_subjectum

  has_attached_file :picture, :default_url => "/images/missing/:class_:attachment_:style.jpg", styles: {
  	tiny: '50x50',
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '400x400'
  }

  def get_subdistrict_name
    name = ""
    if self.activity != nil
      if self.activity.subdistrict != nil
        name = self.activity.subdistrict.name
      end
    end
    return name
  end

  def get_subdistrict
    if self.activity != nil
      return self.activity.subdistrict
    end
  end
end
