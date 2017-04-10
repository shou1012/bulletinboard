require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bulletinboard
  class Application < Rails::Application
    config.to_prepare do
      DeviseController.respond_to :json
    end
  end
end
