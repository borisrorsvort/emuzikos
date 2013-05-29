module ApplicationHelper

  def default_meta_tags
    {
      :description => t('pages.homepage.description'),
      :keywords    => t('pages.homepage.keywords'),
      :separator   => "&mdash;".html_safe,
      :site        => "Emuzikos",
      :reverse => true
    }
  end

  def set_title(value)
    content_for(:title, value)
    wiselinks_title(value)
  end

  %w(description keywords).each do |section|
    define_method section do |value|
      content_for(section.to_sym, value)
    end
  end

  def company
    AppConfig.company.name
  end

  def devise
    AppConfig.site.devise
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def current_page_class(url)
    if current_page?(url)
      "current"
    end
  end

  def current_user_tracking_id
    current_user ? current_user.tracking_id : nil
  end

  def html_tag(attrs={})
    attrs.symbolize_keys!
    html = ""
    html << "<!--[if lt IE 7]> #{ tag(:html, add_class('lt-ie9 lt-ie8 lt-ie7', attrs), true) } <![endif]-->\n"
    html << "<!--[if IE 7]>    #{ tag(:html, add_class('lt-ie9 lt-ie8', attrs), true) } <![endif]-->\n"
    html << "<!--[if IE 8]>    #{ tag(:html, add_class('lt-ie9', attrs), true) } <![endif]-->\n"
    html << "<!--[if gt IE 8]><!--> "

    if block_given? && defined? Haml
      haml_concat(html.html_safe)
      haml_tag :html, attrs do
        haml_concat("<!--<![endif]-->".html_safe)
        yield
      end
    else
      html = html.html_safe
      html << tag(:html, attrs, true)
      html << " <!--<![endif]-->\n".html_safe
      html
    end
  end

  def facebook_button
    link_to user_omniauth_authorize_path(:facebook), :class => "btn btn-primary centered" do
      content_tag(:i, '', class: "icon-facebook") +
      t(:"devise.signin_with", :provider => "Facebook")
    end
  end

  def menu_item(text, icon, link, push = true)
    link_to link , class:  "media #{current_page_class(link)}", data: ({push: true, target: '.content'} if push == true) do
      content = []
      content << content_tag(:div, content_tag(:i, '', class: "icon-#{icon} media-object"), class: 'pull-left')
      content << content_tag(:div, class: "media-body") do
        if text
          text
        end
      end
      safe_join(content)
    end
  end

  private

    def add_class(name, attrs)
      classes = attrs[:class] || ""
      classes.strip!
      classes = " " + classes if !classes.blank?
      classes = name + classes
      attrs.merge(:class => classes)
    end
end
