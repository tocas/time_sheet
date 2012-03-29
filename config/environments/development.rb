TimeSheet::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false
  
  # Disable delivery errors, bad email addresses will be ignored
   config.action_mailer.raise_delivery_errors = true

   # set delivery method to :smtp, :sendmail or :test
   config.action_mailer.delivery_method = :smtp

   # these options are only needed if you choose smtp delivery
   config.action_mailer.smtp_settings = {
     :enable_starttls_auto => true,
     :address        => 'smtp.gmail.com',
     :port           => 587,
     :domain         => 'your.domain.com',
     :authentication => :login,
     :content_type   => "text/html",
     :user_name      => 'secretarytimesheet@gmail.com',
     :password       => '7IAgfyDpWq67'
   }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

