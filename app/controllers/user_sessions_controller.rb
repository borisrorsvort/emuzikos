class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      gflash :success => "Successfully logged in."
      #flash[:notice] = "Successfully logged in."
      redirect_to users_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    gflash :success => "Successfully logged out."
    #flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
