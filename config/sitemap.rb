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
  add trending_path
  add categories_path
  add organizations_path

  PackageSorterJob.perform_now.second.each do |package|
    add package_path(package)
  end

  model_count = 2500

  users = User
    .active_batch_scope
    .joins(:supported_packages)
    .merge(Package.exclude_unregistered_packages)
    .includes(:contributions)
    .group("users.id")
    .order("sum(contributions.score) desc")
    .limit(model_count)

  users.each do |user|
    add user_path(user)
  end

  organizations = Organization
    .active_batch_scope
    .joins(owned_packages: :counter)
    .merge(Package.exclude_unregistered_packages)
    .references(:owned_packages)
    .group("organizations.id")
    .order("count(organizations.id) DESC")
    .order("sum(counters.stargazer) desc")
    .limit(model_count)

  organizations.each do |organization|
    add organization_path(organization)
  end

  categories = Category
    .active_batch_scope
    .joins(:packages)
    .group("categories.id")
    .order("count(categories.id) desc")
    .limit(100)

  categories.each do |category|
    add category_path(category)
  end

  PackageSorterJob.perform_now.second.offset(model_count).first(model_count).each do |package|
    add package_path(package)
  end

end
