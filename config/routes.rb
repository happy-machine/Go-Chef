Rails.application.routes.draw do
  resources :users
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get '/users/:id/edit', to: 'users#edit', as: 'user_edit'
  put '/user/update/:id', to: 'users#update'
end
