source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# 安裝bootstrap
# gem 'bootstrap-sass', '~> 3.4.1'
# gem 'sassc-rails', '>= 2.1.0'
gem 'bootstrap', '~> 4.3.1'
gem 'jquery-rails'
gem 'simple_form'
gem 'devise'
gem 'ahoy_matey'
gem 'font-awesome-rails'

# 下列為 datetime-picker
# moment.js
gem 'momentjs-rails'
# Tempus Dominus
gem 'bootstrap4-datetime-picker-rails'

# ckeditor 相關套件
gem 'ckeditor', github: 'galetahub/ckeditor'
# gem 'ckeditor', '4.2.4'
gem 'mini_magick'

# 提示窗套件
# https://github.com/CodeSeven/toastr
gem 'toastr-rails'

# 處理 file 相關的驗證
gem 'file_validators'

# 國際化
gem 'rails-i18n'

# simple form 月曆
gem 'datetime_picker_input'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  # Use sqlite3 as the database for Active Record
  # gem 'sqlite3'
  gem 'mysql2'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# 如何處理pg無法bundle的問題
# 參考網址：https://medium.com/@hidayatabisena/solving-issues-could-not-find-gem-pg-0-18-when-creating-postgresql-db-in-macosx-high-sierra-2efed94db48e
# brew install postgres
# bundle install
group :production do
  gem 'pg'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
