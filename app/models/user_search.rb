class UserSearch < Searchlight::Search
  search_on User.available_for_listing
  searches  :user_type, :instruments_like, :genres_like, :searching_for, :location

  def search_user_type
    search.where('user_type LIKE ?', user_type)
  end

  def search_instruments_like
    search.joins(:instruments).where('instruments.name LIKE ?', instruments_like)
  end

  def search_genres_like
    search.joins(:genres).where('genres.name LIKE ?', genres_like)
  end

  def search_searching_for
    search.where('searching_for LIKE ?', searching_for)
  end

  def search_location
    search.near(location, 200, :select => "DISTINCT users.*")
  end
end























