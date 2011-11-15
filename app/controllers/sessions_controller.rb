class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id]=user.id
      redirect_to root_path, :notice=>"Welcome, #{user.name}"
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end
  
end
