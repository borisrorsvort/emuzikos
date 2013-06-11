class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_variables
  before_filter :mailer_set_url_options
  before_filter :set_localization

  helper :all
  helper_method :current_user
  layout :set_layout

  def get_variables
    @current_path   = "#{params[:controller]}_#{params[:action]}"
    @current_user   = current_user
    @current_tab    = params[:search][:user_type] rescue ''
    @search         = UserSearch.new(search_params)
    @genres         = Genre.order("name ASC")
    @instruments    = Instrument.order("name ASC")
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
      if session["origin"]
        mixpanel.track 'Signed in', {via: session["origin"]}
      else
        mixpanel.track 'Signed in'
      end

      edit_user_path(resource)
    end
  end

  def set_localization
    if @current_user
      I18n.locale = @current_user.preferred_language
    else
      extract_locale_from_subdomain_or_browser
    end
  end

  def extract_locale_from_subdomain_or_browser
    parsed_locale = request.subdomains.first
    if !request.subdomains.first.nil?
      I18n.available_locales.include?(parsed_locale.to_sym) ? parsed_locale : nil
    else
      set_locale # From gem detect_locale
    end
  end

  def mixpanel
    @mixpanel ||= Mixpanel::Tracker.new AppConfig.mixpanel.api_key, { :env => request.env }
  end

  def set_layout
    request.xhr? ? false : 'application'
  end

  private
    def search_params
      params[:search] || {}
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
