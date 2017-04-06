Rails.application.routes.draw do
  resources :rooms do
    resources :comments, module: :rooms
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
