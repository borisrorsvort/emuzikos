class Search
  attr_reader :options

  def initialize(model, options)
    @model = model
    @options = options || {}
  end
  
  key_filters = %w(user_type searching_for country genre instrument)
  
  key_filters.each do |key_filter|
    define_method key_filter do
      options[key_filter.to_sym]
    end
  end
  
  key_filters.each do |key_filter|
    define_method "has_#{key_filter}?" do
      send(key_filter).present?
    end
  end
  
  def conditions
    conditions = []
    parameters = []

    return nil if options.empty?
    
    if has_user_type?
      conditions << "#{@model.table_name}.user_type LIKE ?"
      parameters << "%#{user_type}%"
    end
    
    if has_searching_for?
      conditions << "#{@model.table_name}.searching_for LIKE ?"
      parameters << "%#{searching_for}%"
    end
    
    if has_country?
      conditions << "#{@model.table_name}.country LIKE ?"
      parameters << "%#{country}%"
    end
    
    if has_genre?
      conditions << "#{@model.table_name}.genre LIKE ?"
      parameters << "%#{genre}%"
    end
    
    if has_instrument?
      conditions << "#{@model.table_name}.#{instrument} = ?"
      parameters << true
    end
    
    unless conditions.empty?
      [conditions.join(" AND "), *parameters]
    else
      nil
    end
  end
  
end