# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

require 'rack/cors'

if !Rails.env.production?
  use Rack::Cors do
    # allow all origins in development
    allow do
      origins '*'
      resource '*',
               :headers => :any,
               :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
               :methods => [:get, :post, :delete, :put, :options]
    end
  end
end

# TODO: Add above code for production

run Rails.application
