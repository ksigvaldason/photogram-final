class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    @like = current_user.likes.build(photo: @photo)
    if @like.save
      redirect_to photos_path, notice: "Like created successfully"
    else
      redirect_to photos_path, alert: 'Error liking photo.'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to photos_path, notice: 'Like deleted successfully'
  end
end
