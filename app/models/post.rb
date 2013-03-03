class Post < ActiveRecord::Base
  attr_accessible :title, :activity_id, :description, :user_id, :picture, :postable_id, :postable_type, :latitude, :longitude, :budget, :dimension, :beneficiary
  acts_as_gmappable validation: false
  belongs_to :postable, :polymorphic => true
  belongs_to :user

  opinio_subjectum

  has_attached_file :picture, 
    styles: {
    	tiny: '50x50',
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>',
      large: '500x300>'
    }

  def comments_count
    comments.count
  end

  def gmaps4rails_address
    "#{self.title}" 
  end

  def get_subdistrict_name
    name = ""
    if self.postable_type == 'Subdistrict'
      name = self.postable.name
    elsif self.postable_type == 'Activity'
      if self.postable.subdistrict != nil
        name = self.postable.subdistrict.name
      end
    end

    return name
  end

  def get_subdistrict
    if self.postable_type == 'Subdistrict'
      return self.postable
    elsif self.postable_type == 'Activity'
      if self.postable.subdistrict != nil
        return self.postable.subdistrict
      end
    end
  end
end
