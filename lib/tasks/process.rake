namespace :process do

  desc "Process categories from organization info"
  task categories: :environment do
    categories = []

    Organization.all.each do |organization|
      next unless organization.name.include? 'Julia'
      next if organization.owned_packages.count < 3

      categories << organization.name.gsub('Julia', '')
    end

    categories.each do |category|
      Category.create! name: category
    end
  end

end
