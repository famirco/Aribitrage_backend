require_relative "boot"
require "rails/all"

module CryptoArbitrageBackend
  class Application < Rails::Application
    config.load_defaults 7.0

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          max_age: 0
      end
    end

    config.action_dispatch.default_headers = {
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*',
      'Access-Control-Allow-Methods' => 'POST, PUT, DELETE, GET, OPTIONS',
      'Access-Control-Allow-Headers' => 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    }
  end
end