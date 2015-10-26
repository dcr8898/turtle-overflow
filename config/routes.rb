Rails.application.routes.draw do

  root to: 'questions#index'

  get    'questions/unanswered', to: 'questions#unanswered'

  resources :questions do
    resources :answers, only: [:create] do
      resources :comments, only: [:create]
    end
    resources :comments, only: [:create]
  end

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  get    'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  get    'register',  to: 'users#new'

  resources :questions, except: [:delete] do
    post 'vote', on: :member
  end

  resources :comments, only: [:create]

  resources :answers, only: [:create]

  resources :tags, only: [:index, :show]

  resources :users, only: [:show, :new, :create]
end
