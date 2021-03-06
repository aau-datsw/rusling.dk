source 'https://rubygems.org'

ruby '2.6.6'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'jquery-rails'
gem 'jsonb_accessor', '~> 1.0.0'
gem 'pg'
gem 'puma', '~> 3.12'
gem 'rails', '~> 5.2.2'
gem 'sentry-raven'
gem 'aws-sdk-s3'

gem 'redis-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'image_processing', '~> 1.2'

gem 'bootstrap', '~> 4.0'
gem 'font-awesome-rails'
gem 'momentjs-rails'

gem 'activeadmin'
gem 'activeadmin_blaze_theme'
gem 'activeadmin_quill_editor'

gem 'bcrypt', '~> 3.1.7'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-saml'

gem 'non-stupid-digest-assets'

gem 'icalendar'
gem 'redcarpet'
gem 'RedCloth'
gem 'tinymce-rails'

gem 'cloudflare'
gem 'cloudflare-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  # Adds support for Capybara system testing and selenium driver
  gem 'rspec', '~> 3.7.0'
  gem 'rspec-rails', '~> 3.7.0'
  gem 'shoulda-matchers', '~> 3.1'

  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'

  gem 'dotenv-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-rails-console', require: false
  gem 'capistrano-rvm'
  # gem 'capistrano3-puma', require: false
  gem 'capistrano-passenger'

  gem 'slackistrano'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
