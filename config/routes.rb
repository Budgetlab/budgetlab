Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#index'

  get '/mentions-legales', to: 'pages#mentions_legales'
  get '/donnees-personnelles', to: 'pages#donnees_personnelles'
  get '/accessibilite', to: 'pages#accessibilite'
  # routes pages erreurs
  match '/500', via: :all, to: 'errors#error_500'
  match '/404', via: :all, to: 'errors#error_404'
  match '/503', via: :all, to: 'errors#error_503'
end
