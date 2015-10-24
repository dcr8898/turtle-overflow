Rails.application.routes.draw do

  root to: 'questions#index'

  resources :questions, only: [:index, :show]

  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
