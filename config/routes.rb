Rails.application.routes.draw do
  root to: 'questions#index'

  get    'questions/unanswered', to: 'questions#unanswered'

  resources :questions, only: [:index, :show] do
    resources :answers, only: [:create]
    resources :comments, only: [:create]
  end

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :tags, only: [:index, :show]

end
