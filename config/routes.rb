Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :cabins do
        member do
          get 'bookings'
        end
      end
      resources :bookings
      get 'profile/all', to: 'profile#all'
      get 'profile', to: 'profile#show'
      put 'profile', to: 'profile#update'

      get 'profile/:user_id/bookings', to: 'profile#bookings', as: :profile_user_bookings
    end
  end
end
