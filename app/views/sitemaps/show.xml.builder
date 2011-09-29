base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=> '1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @users.each do |user|
    xml.url {
      xml.loc("http://www.emuzikos.com/#{user.id}-#{user.username.downcase}")
      xml.changefreq("daily")
    }
  end

  @other_routes.each do |other_route|
    xml.url {
      xml.loc("http://www.emuzikos.com/#{other_route.to_s}")
      xml.changefreq("daily")
    }
  end
end