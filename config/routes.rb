Rails.application.routes.draw do
	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  	# Defines the root path route ("/")
 	root 'pages#index'

   	get '/mentions-legales', to: 'pages#mentions_legales'
  	get '/donnees-personnelles', to: 'pages#donnees_personnelles'
  	get '/accessibilite', to: 'pages#accessibilite'

  	
  	get '/*path', to: 'pages#error_404'
  	match "/404", to: 'pages#error_404', via: :all
  	match "/500", to: 'pages#error_500', via: :all
end
