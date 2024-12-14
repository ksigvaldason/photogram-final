class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(photo_id: params[:photo_id])
    if @like.save
      redirect_back fallback_location: root_path, notice: "Photo liked successfully!"
    else
      redirect_back fallback_location: root_path, alert: "Error liking photo."
    end
  end

  def destroy
    @like = current_user.likes.find_by(photo_id: params[:photo_id])
    @like.destroy
    redirect_back fallback_location: root_path, alert: "Photo unliked."
  end
end
