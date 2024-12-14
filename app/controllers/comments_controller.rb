class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = @photo.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to @photo, notice: 'Comment was successfully added.'
    else
      redirect_to @photo, alert: 'Error adding comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
