class FollowRequestsController < ApplicationController
  def create
    recipient = User.find(params[:recipient_id])
    @follow_request = current_user.sent_follow_requests.build(
      recipient: recipient,
      status: recipient.private? ? "pending" : "accepted"
    )

    if @follow_request.save
      redirect_back fallback_location: users_path, 
        notice: recipient.private? ? "Follow request sent!" : "Following user!"
    else
      redirect_back fallback_location: users_path, alert: "Unable to follow user."
    end
  end

  def destroy
    @follow_request = current_user.sent_follow_requests.find(params[:id])
    @follow_request.destroy
    redirect_back fallback_location: users_path, notice: "Unfollowed successfully."
  end

  def update
    @follow_request = FollowRequest.find(params[:id])
    if @follow_request.update(status: "accepted")
      redirect_back fallback_location: users_path, notice: "Follow request accepted!"
    else
      redirect_back fallback_location: users_path, alert: "Unable to accept follow request."
    end
  end
end
