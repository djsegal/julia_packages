
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://juliapackages.com"

SitemapGenerator::Sitemap.create do

  add users_path
  add packages_path
  add trending_path
  add categories_path
  add suggestions_path

  Category.find_each do |category|
    next if category.name == "Trending"
    add cat_path(category)
  end

  Package.find_each do |package|
    add pkg_path(package)
  end

  User.find_each do |user|
    add usr_path(user)
  end

end
