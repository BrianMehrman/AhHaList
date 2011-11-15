module SessionHelper
  
  def logged_in?
    session[:user_id].present?
  end
  
  def admin?
    logged_in? && current_user.admin?
  end
  
  def current_user
    User.find(session[:user_id])
  end
end
