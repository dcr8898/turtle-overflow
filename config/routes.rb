Rails.application.routes.draw do
  root to: 'questions#index'

  get    'questions/unanswered', to: 'questions#unanswered'

  resources :questions, only: [:index, :create, :new, :show] do
    resources :answers, only: [:create] do
      resources :comments, only: [:create]
    end
    resources :comments, only: [:create]
  end

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  get    'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  resources :tags, only: [:index, :show]

  resources :users, only: [:show, :new, :create]
end
