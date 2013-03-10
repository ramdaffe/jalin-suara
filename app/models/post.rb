class Post < ActiveRecord::Base
  attr_accessible :title, :activity_id, :description, :user_id, :picture, :postable_id, :postable_type, :latitude, :longitude, :budget, :dimension, :beneficiary
  acts_as_gmappable validation: false
  belongs_to :postable, :polymorphic => true
  belongs_to :user

  opinio_subjectum

  searchable do
    text :title, :description
  end

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

  def gmaps4rails_infowindow
    info = ""
    info << "<h5>#{self.get_subdistrict_name}</h5>"
    if self.get_subdistrict != nil
      if self.get_subdistrict.activities != nil
        self.get_subdistrict.activities.each do |activity|
          info << "#{activity.name}<br/>"
          info << "<a href='localhost:3000/activities/#{activity.id}'>Lihat selengkapnya</a><br/>"
        end
      end
    end
    info << "#{self.title}<br/>"
    info << "<a href='localhost:3000/posts/#{self.id}'>Lihat cerita</a>"

    return info
  end

  def gmaps4rails_title
    self.get_subdistrict_name
  end

  def get_activity_name
    name = "-"
    if self.postable_type == 'Activity'
      name = self.postable.name
    end

    return name
  end

  def get_activity
    if self.postable_type == 'Activity'
      return self.postable
    elsif self.postable_type == 'Subdistrict'
      return nil
    else
      return nil
    end
  end

  def get_subdistrict_name
    name = "-"
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
    else
      return nil
    end
  end
end
