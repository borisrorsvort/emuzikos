class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    render :layout => "home"
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      gflash :success => true
      #flash[:notice] = "Successfully logged in."
      redirect_to users_url
    else
      render :action => 'new', :layout => "home"
    end
  end
  
  def destroy
    current_user_session.destroy
    gflash :success => true
    redirect_to root_url
  end
end
