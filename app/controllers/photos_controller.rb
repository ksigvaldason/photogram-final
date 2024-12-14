class PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  before_action :authenticate_user!, except: [:index]

  def create
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to photos_path, notice: "Photo created successfully!"
    else
      redirect_to photos_path, alert: "Error creating photo."
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:image, :caption)
  end
end
