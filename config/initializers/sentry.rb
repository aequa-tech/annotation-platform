# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV.fetch("SENTRY_DNS", '')
  config.enabled_environments = %w[staging production]
end
