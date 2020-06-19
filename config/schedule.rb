# frozen_string_literal: true

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

env :PATH, ENV['PATH'] # 絶対パスから相対パス指定
set :output, 'log/cron.log' # ログの出力先ファイルを設定
set :environment, :development # 環境を設定
#
# every 12.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every 1.minutes do
  # export PATH=$PATH:/usr/local/bin
  runner 'NotificationMailer.notify_user'
  # rake 'task_sample:sample'
end

every 1.minute do
  runner 'Book.create_test'
end

# Learn more: http://github.com/javan/whenever
