class PhotosController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @photos = Photo.joins(:owner).where(users: { private: [false, nil] })
  end

  def create
    @photo = current_user.photos.build(photo_params)
    @photo.comments_count = 0
    @photo.likes_count = 0
    
    if @photo.save
      redirect_to photos_path, notice: "Photo added successfully!"
    else
      @photos = Photo.joins(:owner).where(users: { private: [false, nil] })
      render :index
    end
  end

  def show
    @photo = Photo.find(params[:id])
    @comment = Comment.new
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
