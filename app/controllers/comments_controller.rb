class CommentsController < Opinio::CommentsController
  def create
    @comment = resource.comments.build(params[:comment])

    if current_user != nil
      @comment.owner = send(Opinio.current_user_method)
    else
      if !User.guest_account_available?
        User.create_guest_account
      end
      guest = User.get_guest_account
      @comment.owner = guest
    end
    
    if @comment.save
      flash_area = :notice
      message = t('opinio.messages.comment_sent')
    else
      flash_area = :error
      message = t('opinio.messages.comment_sending_error')
    end

    respond_to do |format|
      format.js
      format.html do
        set_flash(flash_area, message)
        redirect_to(opinio_after_create_path(resource))
      end
    end
  end
end