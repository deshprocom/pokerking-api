source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
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

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'redis'
gem 'redis-rails'
gem 'dotenv-rails'
gem 'jwt'
gem 'second_level_cache'
gem 'resque', github: 'resque/resque'
gem 'faraday'
gem 'kaminari'

# 文件上传处理 相关
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-upyun'
gem 'mini_magick', '~> 4.9', '>= 4.9.2'
# gem 'twilio-ruby'
gem 'twilio-ruby', '~> 5.29.1'

gem 'newrelic_rpm'

gem 'rack-attack'
gem 'jpush'

#  ActionStore - 一步到位的 Like, Follow, Star, Block ... 等动作的解决方案
#  https://ruby-china.org/topics/32262
gem 'action-store'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'database_cleaner'
  gem 'rubocop', require: false
  gem 'rb-readline'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm'
  gem 'capistrano3-puma'
  gem 'capistrano-git-with-submodules', '~> 2.0'
  gem "capistrano-resque", "~> 0.2.2", require: false
  gem 'awesome_print'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
