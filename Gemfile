source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "bootstrap", "~> 5.1.3"
gem "font-awesome-rails"
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem "pry-rails", "~> 0.3.9"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.0"
gem "redis", "~> 4.0"
gem "sassc-rails"
gem "sidekiq"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

group :development, :test do
  gem "bundler-audit"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
end

group :development do
  gem "foreman"
  gem "solargraph"
  gem "tomo"
  gem "tomo-plugin-sidekiq"
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "rails-controller-testing"
  gem "ruby-prof"
  gem "selenium-webdriver"
  gem "test-prof"
  gem "webdrivers"
end
