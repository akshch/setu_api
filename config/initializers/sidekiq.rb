require 'sidekiq'
require 'sidekiq/web'
Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["setu_api", "setu_api@1243"]
end
Sidekiq.configure_server do |config|
  config.redis = AppConfig.redis
end

Sidekiq.configure_client do |config|
   config.redis = AppConfig.redis
end
