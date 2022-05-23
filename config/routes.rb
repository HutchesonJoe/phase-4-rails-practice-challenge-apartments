Rails.application.routes.draw do
  resources :apartments, only: [:index, :create, :update, :destroy]
  resources :leases, only: [:index, :create, :destroy]
  resources :tenants, only: [:index, :create, :update, :destroy]
end
