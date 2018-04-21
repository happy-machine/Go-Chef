Rails.application.routes.draw do
  get 'reviews/index'

  get 'reviews/show'

  get 'reviews/new'

  get 'reviews/edit'

  get 'reviews/delete'

  devise_for :users
  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get '/users/:id/edit', to: 'users#edit', as: 'user_edit'
  get '/test_mode', to: 'users#test', as: 'test_mode'
  put '/user/update/:id', to: 'users#update'
  # get '/users/:id/search', to: 'users#search', as: 'users_search'
  # get '/search', to: 

end

