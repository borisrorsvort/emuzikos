# Optional: Set Amazon S3 credentials. If omitted, sitemaps will go in /public.

SitemapGenerator::Sitemap.s3_access_key_id = "AKIAJWUPX6SF4T3BUQKQ"
SitemapGenerator::Sitemap.s3_secret_access_key = "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"
SitemapGenerator::Sitemap.s3_bucket_name = "emuzikos-production"

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.emuzikos.com"


SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  # 
  # 
  # Examples:
  # 
  add '/'
  add '/login'
  add '/logout'
  add '/contact'
  #   
  sitemap.add users_path, :priority => 0.7, :changefreq => 'daily'
  sitemap.add testimonials_path, :priority => 0.7, :changefreq => 'daily'
  
  #
  # Add individual articles:
  #
  #   Article.find_each do |article|
  #     sitemap.add article_path(article), :lastmod => article.updated_at
  #   end
end