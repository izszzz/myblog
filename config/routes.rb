Rails.application.routes.draw do
  mount_roboto
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  root 'static_pages#home'
  get 'static_pages/privacy'
  get 'static_pages/about'

  get "posts/tags"
  get "posts/categories"
  get "posts/autocomplete"
  resources :posts
  resources :contacts, only: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
