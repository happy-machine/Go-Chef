Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  root "users#index"
  get '/users/:id/edit', to: 'users#edit', as: 'user_edit'
  put '/user/update/:id', to: 'users#update'
  # get '/users/:id/search', to: 'users#search', as: 'users_search'
  # get '/search', to: 

end
