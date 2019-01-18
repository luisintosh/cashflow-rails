Rails.application.routes.draw do
  get 'tools/uploadxls'

  resources :com_pagos
  resources :com_compras
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

  get 'tools/uploadxls', to: 'tools#uploadxls'
  post 'tools/uploadxls', to: 'tools#uploadxls'
  get 'mov_movimientos/clone/:id', to: 'mov_movimientos#clone', as: 'clone_mov'
  get 'com_compras/com_pagos/multipago', to: 'com_compras#multipago', as: 'com_compras_pagar'

  # Para revisar que el sistema esta funcionando
  get '/check.txt', to: proc {[200, {}, ['it_works']]}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
