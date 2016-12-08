Rails.application.routes.draw do
  root to: 'home#index'

  resources :questions

  resources :quiz, only: [:index, :show] do
    collection do
      get :random
    end
    member do
      get :answer
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
