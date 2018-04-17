Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
  get '/users/:id', to: 'users#show', as: 'user'
  get '/user_profile/:id', to: 'user_profile#show', as: 'user_profile'
  put '/user_profile', to: 'user_profile#save', as: 'user_profile_save'

end
