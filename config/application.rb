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
      provider :github, '752d9f0a3344cc25b514', 'f2f6f139bc61587be3209b0b4705122149b2a5f3'
    end

  end
end
