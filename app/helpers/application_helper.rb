module ApplicationHelper

  def company
    AppConfig.company.name
  end

  def devise
    AppConfig.site.devise
  end

  def unread_bullet
    "&bull;"
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

  private

    def add_class(name, attrs)
      classes = attrs[:class] || ""
      classes.strip!
      classes = " " + classes if !classes.blank?
      classes = name + classes
      attrs.merge(:class => classes)
    end
end
