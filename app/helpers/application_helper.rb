module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction), {:class => css_class}
  end
  
  def company
    AppConfig.company.name
  end
  
  def devise
    AppConfig.site.devise
  end
  
  def unread_bullet
    "&bull;"
  end
end
