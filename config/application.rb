require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Railstutorial
    class Application < Rails::Application
        # Initialize configuration defaults for originally generated Rails version.
        config.load_defaults 5.2

        config.action_view.embed_authenticity_token_in_remote_forms = true

        # config.middleware.insert_before ActionDispatch::Cookies, "Rack::SSL"
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration can go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded after loading
        # the framework and any gems in your application.

        # Config Mail
        config.action_mailer.perform_deliveries = true
        config.action_mailer.delivery_method = :smtp

        config.action_mailer.default_url_options = { host: ENV['HOST'], protocol: 'https' }
        # SMTP settings for gmail
        config.action_mailer.smtp_settings = {
            :address              => ENV['MAIL_HOST'],
            :domain               => ENV['MAIL_DOMAIN'],
            :port                 => ENV['MAIL_PORT'],
            :user_name            => ENV['SENDMAIL_USERNAME'],
            :password             => ENV['SENDMAIL_PASSWORD'],
            :authentication       => "plain",
            :enable_starttls_auto => true,
        }
    end
end
