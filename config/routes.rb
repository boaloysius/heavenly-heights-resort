Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :cabins
      resources :bookings
      get 'profile', to: 'profile#show'
      put 'profile', to: 'profile#update'
    end
  end
end
