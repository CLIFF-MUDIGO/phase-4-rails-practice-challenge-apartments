Rails.application.routes.draw do
  resources :apartments do
    resources :tenants, only: [:index, :create]
    resources :leases, only: [:index, :create]
  end

  resources :tenants, except: [:index, :create] do
    resources :leases, only: [:index]
  end

  resources :leases, only: [:destroy]

  # Custom routes
  get '/apartments/:apartment_id/tenants', to: 'tenants#index_by_apartment'
  get '/apartments/:apartment_id/leases', to: 'leases#index_by_apartment'
end