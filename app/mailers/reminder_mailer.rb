class ReminderMailer < ActionMailer::Base

  default from: "andrewstamm@me.com"
  helper ApplicationHelper

  def reminder_email
    mail(to: 'andrewstamm@me.com', subject: 'Your weekly pull list')
  end

end