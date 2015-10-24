Rails.application.routes.draw do
  root to: 'questions#index'

  # this route must appear before the questions resource
  # otherwise, "questions#show" will match first
  get    'questions/unanswered', to: 'questions#unanswered'

  resources :questions, only: [:index, :show]

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :tags, only: [:index, :show]

end
