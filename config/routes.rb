Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root "users#index"
  get '/users/:id/edit', to: 'users#edit', as: 'user_edit'
  get '/test_mode', to: 'users#test', as: 'test_mode'
  put '/user/update/:id', to: 'users#update'
end
