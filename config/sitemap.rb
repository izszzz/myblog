# Set the host name for URL creation

SitemapGenerator::Sitemap.default_host = "https://izszzz-blog.herokuapp.com/"
SitemapGenerator::Sitemap.sitemaps_host= "https://s3-ap-northeast-1.amazonaws.com/#{Rails.application.credentials.s3[:bucket_name]}"
SitemapGenerator::Sitemap.adapter = SitemapGenerator::AwsSdkAdapter.new(
  Rails.application.credentials.s3[:bucket_name],
  aws_access_key_id: Rails.application.credentials.aws[:access_key_id],
  aws_secret_access_key: Rails.application.credentials.aws[:secret_access_key],
  aws_region: 'ap-northeast-1',
)

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  add root_path
  add static_pages_privacy_path
  add static_pages_about_path
  add posts_tags_path
  add posts_categories_path
  add posts_path
  Post.all.each do |post|
    add post_path(post), :lastmod => post.updated_at
  end
end
