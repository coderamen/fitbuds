source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

#for aws cloud storage
gem 'fog'
# photo resizing
gem "mini_magick"
# file upload solution
gem 'carrierwave', '~> 1.0'
# Use for omniauth
gem 'omniauth'
gem 'omniauth-facebook'
# Use for hiding secret keys in a .git ignored yml file
gem 'figaro'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# User Bootstrap select
gem 'bootstrap-select-rails'
# Use Material-icons
gem 'material_icons'
# Use Bootstrap, Font-Awesome and SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'sass-rails', '~> 5.0'
gem "font-awesome-rails"
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# User the jquery timepicker plugin
gem 'bootstrap-timepicker-rails-addon'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# User management gem for password encryption
gem 'clearance'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'redis'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :production do
  gem 'rails_12factor'
  gem 'puma', '~> 3.0'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
