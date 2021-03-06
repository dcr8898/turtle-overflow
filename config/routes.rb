Rails.application.routes.draw do

  root to: 'questions#index'

  get    'questions/unanswered', to: 'questions#unanswered'

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  get    'logout', to: 'sessions#destroy'
  delete 'logout', to: 'sessions#destroy'

  get    'register',  to: 'users#new'

  resources :questions, except: [:delete] do
    post 'vote', on: :member
  end

  resources :comments, only: [:create, :edit, :update]

  resources :answers, only: [:create]

  resources :tags, only: [:index, :show]

  resources :users, only: [:show, :new, :create]
end
