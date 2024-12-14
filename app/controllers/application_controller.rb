class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, if: :devise_controller?
  
  protected

  def authenticate_user!
    unless current_user
      redirect_to new_user_session_path, alert: "You need to sign in or sign up before continuing."
      return
    end
  end  
  
  def after_sign_in_path_for(user)
    photos_path
  end
  
  def after_sign_out_path_for(user)
    photos_path
  end
end
