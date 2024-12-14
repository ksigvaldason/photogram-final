class CommentsController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @comment = Comment.new(
      body: params[:body],
      photo_id: @photo.id,
      author_id: current_user.id
    )

    if @comment.save
      redirect_to @photo, notice: 'Comment was successfully added.'
    else
      redirect_to @photo, alert: 'Error adding comment.'
    end
  end
end
