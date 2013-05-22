source 'https://rubygems.org'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'devise'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end


group :development , :test do
  gem 'sqlite3'
  gem 'spork'
  gem 'rspec-rails'
end

group :test do
  gem 'cucumber-rails' , :require => false
  gem 'webrat'
  gem 'factory_girl_rails'
#  Object.send :remove_const, :Config ; Config = RbConfig ; # kludge to supress warning
  gem 'watchr'
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end