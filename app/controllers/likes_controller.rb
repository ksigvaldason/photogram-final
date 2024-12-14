class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.new(
      fan_id: current_user.id,
      photo_id: params[:photo_id]
    )

    if @like.save
      redirect_back(fallback_location: root_path, notice: "Photo liked successfully.")
    else
      redirect_back(fallback_location: root_path, alert: "Could not like photo.")
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path, alert: "Photo unliked.")
  end
end
