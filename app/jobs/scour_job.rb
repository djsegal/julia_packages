class ScourJob < JuliaJob
  queue_as :default

  def perform(*args)
    Dir.foreach("tmp/scour") do |directory|
      next if directory.starts_with? '.'
      file_name = "tmp/scour/#{directory}/data.yml"

      next unless File.exist? file_name
      updated_time = File.mtime file_name

      next if updated_time > 1.week.ago
      FileUtils.rm_rf "tmp/scour/#{directory}"
    end

    system "#{@sys_run} scour:packages"
  end
end
