source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.0"
gem "propshaft"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
