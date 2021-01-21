require("#{Rails.root}/lib/tasks/Crawler/PTT/main.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/process_files.rb")

namespace :Analysis do
  desc "Crawler for ptt"
  task :ptt => :environment do
    table = CSV.parse(File.read("#{Rails.root}/data/PTT/analysis/boards_url.csv"), headers: false)
    table_title = table[0][0].gsub("https://www.ptt.cc/bbs/", "").gsub("/index.html", "")
    `python3 lib/tasks/Crawler/PTT/data_cleaning.py`
    mvfinish_files(table_title)
  end
end
