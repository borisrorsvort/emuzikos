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

  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url,
      :loaderMsg  => t(:'pagination.loading_more_results'),
      :pagination => ".pagination",
      :loaderImage => "/assets/icons/ajax-loader-pagiantion.gif"
    }

    container && opts[:container] ||= container

    javascript_tag("$('#inner_content .users_list').pageless(#{opts.to_json});")
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
