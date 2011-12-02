source 'http://rubygems.org'

gem 'rails', '3.1.2.rc2'

gem 'sqlite3'
gem 'jquery-rails'

gem "devise"
gem "carrierwave"
gem "rmagick"
gem "simple_form"
gem "responders"

group :assets do
  gem 'sass-rails', '~> 3.1.5.rc.2'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem "rspec-rails"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "spork", "~> 0.9.0.rc"
end

group :development do
  gem "wirble"
  gem "hirb"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem "database_cleaner"
  gem "launchy"
end