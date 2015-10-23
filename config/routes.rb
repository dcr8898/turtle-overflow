Rails.application.routes.draw do
  resources :tags, only: [:index, :show]
end
