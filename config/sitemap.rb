# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://juliaobserver.com"

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
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add packages_path
  add users_path
  add categories_path
  add organizations_path

  model_count = 1000

  PackageSorterJob.perform_now.second.first(model_count).each do |package|
    add package_path(package)
  end

  users = User
    .joins(:supported_packages)
    .merge(Package.exclude_unregistered_packages)
    .includes(:contributions)
    .group("users.id")
    .order("sum(contributions.score) desc")
    .limit(model_count)

  users.each do |user|
    add user_path(user)
  end

end
