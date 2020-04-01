
# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://juliapackages.com"

SitemapGenerator::Sitemap.create do

  # add trending_path

  add packages_path

  Category.find_each do |category|
    next if category.name == "Trending"
    add cat_path(category)
  end

  add categories_path

  Package.find_each do |package|
    add pkg_path(package)
  end

end
