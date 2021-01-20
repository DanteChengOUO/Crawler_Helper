def update_boards()
  data_boards = CSV.read("#{Rails.root}/lib/tasks/Crawler/PTT/boards_url.csv")
  data_boards.each do |arr|
    colums = [:name, :alias, :source_id]
    values = [[arr[2], arr[3], 2]]
    Board.import colums, values, validate: false
  end
end

def csv_to_psql()
  data_posts = CSV.read("#{Rails.root}/lib/tasks/Crawler/PTT/post_content.csv")
  data_posts.each do |arr|
    post_colums = [:alias, :url, :author, :title, :created_at, :comment_count, :content, :pid, :clean, :token, :no_stop, :keyword, :sentiment]
    post_values = [[arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8], arr[9], arr[10], arr[11], arr[12], arr[13]]]

    Post.import post_colums, post_values, validate: false
  end

  data_comments = CSV.read("#{Rails.root}/lib/tasks/Crawler/PTT/comment_content.csv")

  data_comments.each do |arr|
    comment_colums = [:alias, :url, :author, :created_at, :content, :pid, :clean, :token, :no_stop, :keyword, :sentiment]
    comment_values = [[arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8], arr[9], arr[10], arr[11]]]

    Comment.import comment_colums, comment_values, validate: false
  end

  puts "=====CSV write into PSQL Success====="
end

def mv_files(table_title)
  clean_title = table_title
  Dir.mkdir("#{Rails.root}/data/PTT/#{clean_title}") unless Dir.exists?("#{Rails.root}/data/PTT/#{clean_title}")
  FileUtils.mv("#{Rails.root}/data/PTT/post_url.csv", "#{Rails.root}/data/PTT/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/PTT/post_content.csv", "#{Rails.root}/data/PTT/#{clean_title}/")
  FileUtils.mv("#{Rails.root}/data/PTT/comment_content.csv", "#{Rails.root}/data/PTT/#{clean_title}/")
end

def board_folder()
  @folder_name = DateTime.now.strftime("%F %R").gsub(":", "-")
  Dir.mkdir("#{Rails.root}/data/#{@folder_name}")
end

def mvfinish_files(table_title)
  clean_title = table_title
  Dir.mkdir("#{Rails.root}/data/PTT/#{clean_title}_finish") unless Dir.exists?("#{Rails.root}/data/PTT/#{clean_title}_finish")
  FileUtils.mv("#{Rails.root}/data/PTT/analysis/post_url.csv", "#{Rails.root}/data/PTT/#{clean_title}_finish/")
  FileUtils.mv("#{Rails.root}/data/PTT/analysis/post_content.csv", "#{Rails.root}/data/PTT/#{clean_title}_finish/")
  FileUtils.mv("#{Rails.root}/data/PTT/analysis/comment_content.csv", "#{Rails.root}/data/PTT/#{clean_title}_finish/")
end