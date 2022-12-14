source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.6', '>= 6.1.6.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
gem 'sorcery', '~> 0.16.3'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'mechanize', '~> 2.8'
gem 'net-smtp'
gem 'net-imap'
gem 'net-pop'
gem 'rakuten_web_service'
gem 'rails-i18n', '~> 6.0'
# Use Active Storage variant
gem 'image_processing', '~> 1.2'
gem 'enum_help'
gem 'active_model_serializers'
gem 'draper'
gem 'kaminari'
gem 'config'
gem 'meta-tags'
gem 'sitemap_generator'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
end

group :development do
  gem 'annotate'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'foreman'
  gem 'htmlbeautifier'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'letter_opener_web', '~> 2.0'
end

group :test do
  gem 'webdrivers'
  gem 'capybara'
  gem 'database_cleaner-active_record'
end

group :production do
  gem 'pg'
  gem 'aws-sdk-s3', require: false
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
