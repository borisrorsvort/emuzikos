class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_variables
  before_filter :mailer_set_url_options
  before_filter :set_locale

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
    stored_location_for(resource) ||
    if resource.is_a?(AdminUser)
      admin_dashboard_path
    else
      edit_user_path(resource)
    end
  end

  def after_sign_up_path_for(resource)
    edit_user_path(current_user)
  end

  def set_locale
    if @current_user
      I18n.locale = @current_user.preferred_language
    else
      I18n.locale = extract_locale_from_subdomain || I18n.default_locale
    end
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    unless request.subdomains.first.nil?
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    end
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
