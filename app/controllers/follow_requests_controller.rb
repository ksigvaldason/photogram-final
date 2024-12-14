class FollowRequestsController < ApplicationController
  def create
    @follow_request = FollowRequest.new(
      sender_id: current_user.id,
      recipient_id: params[:recipient_id],
      status: User.find(params[:recipient_id]).private? ? "pending" : "accepted"
    )

    if @follow_request.save
      redirect_back fallback_location: users_path, notice: "Follow request sent!"
    else
      redirect_back fallback_location: users_path, alert: "Unable to follow user."
    end
  end

  def destroy
    @follow_request = FollowRequest.find(params[:id])
    @follow_request.destroy
    redirect_back fallback_location: users_path, notice: "Unfollowed successfully."
  end
end
