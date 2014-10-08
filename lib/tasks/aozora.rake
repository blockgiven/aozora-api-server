require 'open-uri'
require 'tempfile'
require 'zip'

namespace :aozora do
  desc 'download csv from aozora.gr.jp'
  task :download do
    {
      "list_person_all_utf8.csv"          => "http://www.aozora.gr.jp/index_pages/list_person_all_utf8.zip",
      "list_person_all_extended_utf8.csv" => "http://www.aozora.gr.jp/index_pages/list_person_all_extended_utf8.zip"
    }.each do |filename, download_url|
      dest_path = Rails.root.join('app', 'assets', 'csvs', filename)

      next if File.exist?(dest_path)

      zipfile = open(download_url) do |zip|
        Tempfile.open(%w(csv .zip), encoding: Encoding::BINARY) do |zipfile|
          zipfile.write zip.read
          zipfile
        end
      end

      Zip::File.open(zipfile.path) do |zipfile|
        entry = zipfile.find_entry(filename)
        entry.extract(dest_path)
      end
    end
  end
end

# download aozora csv before assets:precompile run
Rake::Task['assets:precompile'].enhance(['aozora:download'])
