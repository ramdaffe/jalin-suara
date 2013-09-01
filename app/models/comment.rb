class Comment < ActiveRecord::Base
  opinio
  attr_accessible :owner_id, :commentable_id, :commentable_type, :body, :created_at, :updated_at, :guest_name, :guest_email

  def guest_owner?
    guest_id = User.get_guest_account.id
    return self.owner_id == guest_id
  end

  def get_commenter_name
    commenter_name = ""

    commenter = User.find(self.owner_id)
    if commenter != nil
      commenter_name = commenter.username
    end

    return commenter_name
  end

  def get_story
    story = Post.find(self.commentable_id)
    if story != nil
      return story
    end
  end

  def get_story_title
    story_title = ""

    story = Post.find(self.commentable_id)
    if story != nil
      story_title = story.title
    end

    return story_title
  end
end
