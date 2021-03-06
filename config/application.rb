require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module KaizenApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Cronofy.configure do |config|
    #   cronofy = Cronofy::Client.new(access_token: 'xoTQMfDkfJM19CBoBXIMFh4DKvUnDJlR')
    #   calendars = cronofy.list_calendars
    # end
    config.active_record.raise_in_transactional_callbacks = true

    config.middleware.use OmniAuth::Builder do
      provider :github, "89b4988efb2612e733ee", "12056f233a17c13ea595bef704f6af17309ae206"
    end

  end
end
