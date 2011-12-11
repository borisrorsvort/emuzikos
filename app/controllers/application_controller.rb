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

  unless ActionController::Base.consider_all_requests_local
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :rescue_action_in_public
    rescue_from ActionController::UnknownController, :with => :render_not_found
    # customize these as much as you want, ie, different for every error or all the same
    rescue_from ActionController::UnknownAction, :with => :render_not_found
  end

  def render_not_found(exception)
    render "/errors/404.html.haml", :layout => "errors", :status => 404
  end

  def render_error(exception)
    # you can insert logic in here too to log errors
    # or get more error info and use different templates
    render "/errors/500.html.haml", :layout => "errors", :status => 500
  end

  private

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
