source "https://rubygems.org"

ruby "3.3.0"

gem "rails", "~> 7.1.3"
gem "sprockets-rails"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "redis", ">= 4.0.1" # Use Redis adapter to run Action Cable in production
gem "sidekiq"

gem "sentry-ruby"
gem "sentry-rails"

gem "pundit"

gem "infold", require: false
# Gems required by infold:
gem "active_decorator"
gem "devise"
gem "devise-i18n"
gem "enum_help"
gem "haml-rails"
gem "kaminari"
gem "view_component"
gem "aws-sdk-s3", require: false

gem "jsbundling-rails"
gem "cssbundling-rails"

gem "turbo-rails"
gem "stimulus-rails"

gem "slim-rails"
gem "simple_form"

gem "jbuilder" # Build JSON APIs with ease [https://github.com/rails/jbuilder]

gem "tzinfo-data", platforms: %i[windows jruby] # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "bootsnap", require: false # Reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem "brakeman"
  gem "bundler-audit"
  gem "factory_bot_rails"
  gem "fasterer"
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails", "~> 6.1.2"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
  gem "shoulda-matchers", require: false
  gem "slim_lint", require: false
  gem "dotenv"
end

group :development do
  gem "web-console"
  gem "overcommit"
  gem "letter_opener"
end

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
