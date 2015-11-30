
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'

# Use postgresql as the database for Active Record
gem 'pg'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rails-api'
gem 'kaminari'
gem 'api-pagination'
gem 'require_all'
gem 'activerecord-postgis-adapter'
gem 'squeel'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'progress_bar'
gem 'neo4j'
gem 'dotenv-rails'
gem 'geocoder'

group :development do

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'annotate'
  gem 'rubocop'
  gem 'sequel'
  gem 'colorize'

end

group :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers', require: false
  gem 'sunspot_matchers'
  gem 'json_spec'
end

group :deployment do
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger'
  gem 'dlss-capistrano'
end
