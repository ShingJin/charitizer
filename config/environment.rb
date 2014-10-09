# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Charitizer::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => app30042091@heroku.com,
  :password       => ccbrrrqu,
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}