class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      redirect_to new_session_path, :notice => "You must be logged in to do this."
    end
  end
  
end
