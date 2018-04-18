Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root "users#index"
  #put '/user', to: 'users#update', as: 'user_update'
  get '/users/:id/edit', to: 'users#edit', as: 'user_edit'

  put '/user/update', to: 'users#update'
end
