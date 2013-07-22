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
      thumbnail: '220x130!',
      square: '200x200#',
      medium: '300x300>',
      large: '620x260!'
    }

  def comments_count
    count = 0

    self.comments.each do |comment|
      count += 1
      if comment.comments != nil
        count += comment.comments.count
      end
    end

    return count
  end

  def gmaps4rails_address
    "#{self.title}" 
  end

  def gmaps4rails_infowindow
    info = ""
    info << "<h5>#{self.title}</h5>"
    info << "<a href='/posts/#{self.id}'>Lihat cerita</a>"

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

  def get_author_name
    name = ""
    if self.user != nil
      name = self.user.username
    end

    return name
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
