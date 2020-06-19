# frozen_string_literal: true

namespace :task_sample do
  desc 'Run tests'
  task sample: :environment do
    NotificationMailer.notify_user
  end
end
