Rails.application.routes.draw do

  resources :items, only: [:index, :show] do
    resources :users, only: [:index, :show, :create]
  end

  resources :users, only: [:show]

end
