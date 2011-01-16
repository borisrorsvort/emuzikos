class Search
  attr_reader :options

  def initialize(model, options)
    @model = model
    @options = options || {}
  end
  
  def user_type
    options[:user_type]
  end
  
  def searching_for
    options[:searching_for]
  end

  def country
    options[:country]
  end
  
  def genre
    options[:genre]
  end
  
  def instrument
    options[:instrument]
  end
  
  def has_user_type?
    user_type.present?
  end
  
  def has_searching_for?
    searching_for.present?
  end
  
  def has_country?
    country.present?
  end
  
  def has_genre?
    genre.present?
  end
  
  def has_instrument?
    instrument.present?
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