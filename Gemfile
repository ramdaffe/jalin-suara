source 'https://rubygems.org'

gem 'rails', '3.2.11'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'twitter-bootstrap-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development, :test do
  gem 'mysql2'
end

group :production do
  gem 'pg'
end

gem 'thin'
gem 'simple_form'
gem 'gmaps4rails'
gem 'flickraw'
gem 'devise'

# Paperclip and AWS S3
gem 'aws-sdk', '~> 1.6.0'
gem 'paperclip', '~> 3.4.0'