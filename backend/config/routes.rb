Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routes
  namespace :api do
    namespace :v1 do
      get 'sales_by_category', to: 'dashboard#sales_by_category'
      get 'monthly_sales', to: 'dashboard#monthly_sales'
      get 'sales_trend', to: 'dashboard#sales_trend'
      get 'product_comparison', to: 'dashboard#product_comparison'
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
