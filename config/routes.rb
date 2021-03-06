require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => "/sidekiq"
  namespace :api do
    namespace :v1 do
      post 'centers', to: 'centers#index'
      post 'pincode', to: 'centers#pincode'
    end
  end
end
