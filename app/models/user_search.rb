class UserSearch < Searchlight::Search
  search_on User.available_for_listing
  searches  :user_type, :instruments_like, :genres_like, :searching_for, :location

  def search_user_type
    search.where('user_type = ?', user_type)
  end

  def search_instruments_like
    search.joins(:instruments).where('instruments.name = ?', instruments_like)
  end

  def search_genres_like
    search.joins(:genres).where('genres.name = ?', genres_like)
  end

  def search_searching_for
    search.where('searching_for = ?', searching_for)
  end

  def search_location
    search.near(location, 200, :select => "DISTINCT users.*")
  end
end













