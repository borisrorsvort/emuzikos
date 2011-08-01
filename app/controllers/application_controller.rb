class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_variables
  before_filter :mailer_set_url_options

  helper :all
  helper_method :current_user

  def get_variables
    @current_path = "#{params[:controller]}_#{params[:action]}"
    @current_user = current_user
  end
  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  ### DEVISE REDIRECTION SECTION

  def after_sign_in_path_for(resource)
      edit_user_path(resource)
  end

  def after_sign_up_path_for(resource)
      edit_user_path(current_user)
  end

  protected

  private
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
   
end
