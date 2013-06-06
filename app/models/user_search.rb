class UserSearch < Searchlight::Search
  search_on User.available_for_listing
  searches  :user_type, :instruments_like, :genres_like, :searching_for, :location

  def search_user_type
    unless user_type.blank?
      search.where('user_type = ?', user_type)
    end
  end

  def search_instruments_like
    unless instruments.blank?
      search.joins(:instruments).where('instruments.name = ?', instruments_like)
    end
  end

  def search_genres_like
    unless genres_like.blank?
      search.joins(:genres).where('genres.name = ?', genres_like)
    end
  end

  def search_searching_for
    unless searching_for.blank?
      search.where('searching_for = ?', searching_for)
    end
  end

  def search_location
    unless location.blank?
      search.near(location, 200, :select => "DISTINCT users.*")
    end
  end
end













