Rails.application.routes.draw do
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :users, only: :create
    end
  end
end
