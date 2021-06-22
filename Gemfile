source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'rails',     '6.1.3.1'
gem 'pg',        '~> 1.1'
gem 'unicorn',   '6.0.0'
#gem 'puma',     ' 5.3.0'
gem 'redis',     '3.3.3'
gem 'bootsnap',  '1.7.5'
gem 'httparty',  '0.18.1'
gem 'sidekiq',   '5.0.3'
gem 'whenever',  '1.0.0'
gem 'mina',      '1.2.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '3.5.1'
  gem 'spring', '2.1.1'
  gem 'pry',    '0.14.1'
end