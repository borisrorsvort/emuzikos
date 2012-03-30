base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=> '1.0', :encoding => "UTF-8"

xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @users.each do |user|
    xml.url {
      if request.subdomains.first != ""
        xml.loc("#{user_url(user)}")
      else
        xml.loc("#{user_url(user, :subdomain => request.subdomains.first.to_s)}")
      end
      xml.changefreq("daily")
    }
  end

  @other_routes.each do |other_route|
    xml.url {
      xml.loc("#{root_url}#{other_route.to_s}")
      xml.changefreq("daily")
    }
  end
end