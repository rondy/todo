source 'http://rubygems.org'

gem 'rails', '3.1.2.rc2'

gem 'sqlite3'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails', '~> 3.1.5.rc.2'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem "rspec-rails"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem "spork"
end

group :development do
  gem "wirble"
  gem "hirb"
end

group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
end