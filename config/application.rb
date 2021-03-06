require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AskUp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Load application ENV vars and merge with existing ENV vars. Loaded here so can use values in initializers.
    #   https://quickleft.com/blog/simple-rails-app-configuration-settings/
    # Loaded in before_configuration so it can be used in environments/*
    #   http://railsapps.github.io/rails-environment-variables.html
    config.before_configuration do
      ENV.update YAML.load_file('config/application.yml')[Rails.env] rescue {}
    end

    # Mail server configuration for all environments, can override these values in config/environments/*.rb
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: ENV["mail_host_address"],
      port: ENV["mail_host_port"],
      domain: ENV["mail_domain"],
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV["mail_host_username"],
      password: ENV["mail_host_password"]
    }
  end
end
