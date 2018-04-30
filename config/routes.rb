Rails.application.routes.draw do
  #devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions" , registrations: "users/registrations"}

  resources :users do
    resources :images
    resources :reviews
    resources :contact
  end

 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get '/test_mode', to: 'users#test', as: 'test_mode'
  get '/search', to: 'users#search', as: 'users_search'
  get '/welcome', to: 'users#welcome', as: 'welcome_form'
  post '/welcome', to: 'users#postcode_added', as: 'welcome_post'
  

  # get '/users/:id/search', to: 'users#search', as: 'users_search'
  # get '/search', to: 

end

