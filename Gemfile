source 'https://rubygems.org'

ruby '2.1.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
gem 'pg'

# heroku something
gem 'rails_12factor'

# puma web server
gem 'puma'

# https://github.com/heroku/rack-timeout
gem "rack-timeout"

# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
#gem 'coffee-rails', '~> 4.1.0'

# you need imagemagic http://www.austinstory.com/integrating-wicked-pdf-paperclip-and-mercury-rails-for-an-editable-web-document-that-can-be-exported-to-pdf/#comment-1933
gem 'paperclip'

# mighty Amazon S3 for Amazon static assets
gem 'aws-sdk', '< 2.0'

gem 'jquery-fileupload-rails'

# for ajax to be able to respond with json
gem 'responders'

# for pagination based on model
gem 'will_paginate'

#gem 'font-awesome-rails' getting it from CDN
gem 'wysiwyg-rails'

# Use jquery as the JavaScript library
#gem 'jquery-rails' I am currently using Google CDN for this
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# https://github.com/lucasefe/themes_for_rails
gem 'themes_for_rails'

# highligting source code https://github.com/ophilbert/syntax-highlighter-rails
#gem 'syntax-highlighter-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  # ERD visualisation http://rails-erd.rubyforge.org/install.html, use by "rake erd"
  gem 'rails-erd'
end

