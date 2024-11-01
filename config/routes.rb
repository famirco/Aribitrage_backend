Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tokens, only: [:index]
      resources :price_records, only: [:index]
      resources :arbitrage_opportunities, only: [:index]
      resources :config, only: [:index]
    end
  end
end