desc "This task is called by the Heroku scheduler add-on"


task :update_raised_amount => :environment do

end

task :send_reminders => :environment do
  Reminder.send_out_emails
end
