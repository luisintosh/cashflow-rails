Rails.application.routes.draw do
  resources :com_articulos
  resources :empleados
  resources :mov_movimientos
  resources :emp_clasificacions
  resources :emp_cuentabs
  resources :emp_locacions
  resources :emp_clientes
  resources :emp_proveedors
  devise_for :users
  #get 'panel/index'

  root 'panel#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
