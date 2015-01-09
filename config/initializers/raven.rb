require 'raven'

Raven.configure do |config|
  config.dsn = secret_key_base: <%= ENV["RAVEN_DSN"] %>
end
