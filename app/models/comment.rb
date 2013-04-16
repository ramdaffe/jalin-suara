class Comment < ActiveRecord::Base
  opinio

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
