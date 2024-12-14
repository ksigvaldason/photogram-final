class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })

  def index
    @photos = Photo.all
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.owner_id = current_user.id
    @photo.comments_count = 0
    @photo.likes_count = 0

    if @photo.save
      redirect_to photos_path, notice: "Photo created successfully."
    else
      redirect_to photos_path, alert: "Photo could not be created."
    end
  end

  def feed
    following_ids = current_user.sent_follow_requests.where(status: "accepted").pluck(:recipient_id)
    @feed_photos = Photo.where(owner_id: following_ids)
  end

  def discovery
    following_ids = current_user.sent_follow_requests.where(status: "accepted").pluck(:recipient_id)
    liked_photo_ids = Like.where(fan_id: following_ids).pluck(:photo_id)
    @discovery_photos = Photo.where(id: liked_photo_ids)
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image)
  end
end
