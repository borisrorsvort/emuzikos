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
      :loaderImage => "/images/icons/ajax-loader-pagiantion.gif"
    }

    container && opts[:container] ||= container

    javascript_tag("$('#inner_content .users_list').pageless(#{opts.to_json});")
  end
end
