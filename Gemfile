source 'https://rubygems.org'

ruby "2.3.1"

gem 'rails', '4.1.16'
gem 'pg'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'devise', '~> 3.0.4'
gem 'slim'
gem 'active_model_serializers'
gem 'jquery-ui-rails'
gem 'acts_as_list'
gem 'nokogiri'
gem "skylight"
gem 'figaro'

# coverband
gem 'coverband', '1.5.0'
# local
#gem 'coverband', '1.4.0', :path => '../coverband'


gem 'redis'

# verify coverband works with default puma config
gem 'puma'

# looking at money and money-rails to store values
# gem 'money'
# upgrade rails and devise first and wait till I care about having an admin
# gem 'activeadmin', github: 'activeadmin'

group :doc do
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl'
end

group :development, :test do
  gem 'pry-byebug'
end
