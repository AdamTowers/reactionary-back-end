Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users
      resources :rooms

      post '/sessions/', to: 'sessions#create', as: 'sessions'
      get '/random-word', to: 'words#random', as: 'words'
    end
  end

  mount ActionCable.server => '/cable'
end
