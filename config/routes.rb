Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'main_page#index'
  resources :main_page, only: [:new, :create, :index] do
    get 'new_crash', on: :collection
    post 'add_crash', on: :collection
    get 'search', on: :collection
    get 'repair', on: :collection
    get 'pay', on: :collection
  end
end
