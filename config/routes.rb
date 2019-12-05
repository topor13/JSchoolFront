Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'main#index'

  resources :main, only: [:new, :create, :index] do
    get 'order', on: :collection
    post 'order', on: :collection
    get 'get_models', on: :collection
  end

  namespace :panel, as: 'panel' do
    resources :brands, only: [:index] do
      get 'delete_brand', on: :collection
      get 'edit_brand', on: :collection
      get 'create_brand', on: :collection
    end
    resources :parts, only: [:index] do
      get 'delete_part', on: :collection
      get 'edit_part', on: :collection
      get 'create_part', on: :collection
    end
    resources :models, only: [:index] do
      get 'delete_model', on: :collection
      get 'edit_model', on: :collection
      get 'create_model', on: :collection
    end
    resources :masters, only: [:index] do
      get 'delete_master', on: :collection
      get 'edit_master', on: :collection
      get 'create_master', on: :collection
      get 'free_master', on: :collection
    end

    root 'brands#index'
  end
end
