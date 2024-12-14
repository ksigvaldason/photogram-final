class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by!(username: params[:id])
    @pending_requests = @user.received_follow_requests.where(status: "pending") if @user.private?
  end

  def feed
    @user = User.find_by!(username: params[:id])
    following_ids = @user.sent_follow_requests.where(status: "accepted").pluck(:recipient_id)
    @feed_photos = Photo.where(owner_id: following_ids).order(created_at: :desc)
  end
end
