Rails.application.routes.draw do
  resource :authentication_token, only: [:update, :destroy]
  devise_for :users, controllers: { sessions: "sessions" }
  resources :users, :only => [:show]
  resources :rooms do
    resources :comments, module: :rooms
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
