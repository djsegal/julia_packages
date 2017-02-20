namespace :downloads do

  desc "make downloadable for packages"
  task packages: :environment do
    book = Spreadsheet::Workbook.new

    sheet = book.create_worksheet name: 'Julia Packages'

    package_attributes = [:name, :description]

    sheet.update_row 0, *package_attributes.map(&:to_s).map(&:titleize), 'Categories'

    package_list = Package
      .exclude_unregistered_packages
      .active_batch_scope
      .order(:name)

    package_list.each_with_index do |package, index|
      categories_list = package.categories

      if categories_list.empty?
        categories = 'x'
      elsif categories_list.length == 1
        categories = categories_list.first.name
      else
        categories = categories_list.map(&:name).inspect
      end

      sheet.update_row \
        (index+1), package.name, package.description, categories
    end

    FileUtils.mkdir_p(@downloads_directory) \
      unless File.directory? @downloads_directory

    spreadsheet_name = "julia_packages.xls"
    spreadsheet_path = "#{@downloads_directory}/julia_packages.xls"

    book.write spreadsheet_path

    zipfile_name = "#{@downloads_directory}/julia_packages.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      zipfile.add(spreadsheet_name, spreadsheet_path)
    end

    download_name = 'packages'
    if Download.friendly.exists? download_name
      download = Download.friendly.find download_name
    else
      download = Download.create! name: download_name
    end
    download.update file: zipfile_name
  end

end
