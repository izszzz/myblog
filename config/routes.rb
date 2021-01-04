Rails.application.routes.draw do
  devise_for :admins
  root "static_pages#home"
  get 'static_pages/home'
  get 'static_pages/about'
  get 'static_pages/contact'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
