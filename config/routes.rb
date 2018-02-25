Rails.application.routes.draw do
  resources :emp_proveedors
  devise_for :users
  get 'panel/index'

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
