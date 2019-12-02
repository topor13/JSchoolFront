Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'main#index'

  resources :main, only: [:new, :create, :index] do
    get 'order', on: :collection
    post 'order', on: :collection
    get 'get_models', on: :collection
  end
end
