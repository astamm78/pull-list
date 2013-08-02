require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "Tasks to be run by the Heroku scheduler"
task :send_reminder_task => :environment do
  puts "Starting task..."
  if time_to_send_reminder? && List.last.sent == false
    send_reminder
    List.last.update_attributes(sent: true)
  end
  puts "...and has now been completed."
end