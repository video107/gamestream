source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Pg is the Ruby interface to the {PostgreSQL RDBMS}
#gem 'rails_12factor', group: :production
# Use sqlite3 as the database for Active Record
gem 'capistrano-rails', :group => :development
gem 'capistrano-passenger', :group => :development
gem 'mysql2'

gem 'faraday'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'bootstrap-sass'
# css autoprefixer for -webkit-...
gem 'autoprefixer-rails'
# pagenate plugin for rails
gem "kaminari"
gem "brakeman", :require => false
# user login plugin
gem 'devise'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# faker data generation
gem 'faker'
# , :group => :development
gem 'bootstrap-datepicker-rails'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# another pagenate for rails
#gem "omniauth-facebook"

# gem "omniauth-google"
gem 'omniauth-google-oauth2'
# gem "omniauth"
# poor guy search bar
gem 'ransack'
gem 'paperclip'
# Use Unicorn as the app server
# gem 'unicorn'
gem "letter_opener", :group => :development

# Soft deletion gem
gem 'paper_trail', '~> 4.0.0.rc'
# tracking gem (like GA in ROR)
# gem 'ahoy_matey'
# initiate user uuid
gem 'activeuuid', '>= 0.5.0'
gem 'bower-rails', '~> 0.10.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rack-mini-profiler'
  gem 'sqlite3'
  gem 'byebug'
  gem "rspec-rails"
  gem 'xray-rails'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
