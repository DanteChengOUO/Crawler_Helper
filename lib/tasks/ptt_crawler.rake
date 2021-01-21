require("#{Rails.root}/lib/tasks/Crawler/PTT/main.rb")
require("#{Rails.root}/lib/tasks/Crawler/PTT/process_files.rb")

namespace :Crawler do
  desc "Crawler for ptt"
  task :ptt => :environment do
    get_post_url(["1/21","1/20","1/19","1/18","1/17","1/16","1/15","1/14"]) # 設定日期，區間內的日期要全部列出
  end
end
