Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :images
    resources :reviews
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get '/test_mode', to: 'users#test', as: 'test_mode'

  # get '/users/:id/search', to: 'users#search', as: 'users_search'
  # get '/search', to: 

end

