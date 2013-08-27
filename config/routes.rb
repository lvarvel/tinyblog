require 'rails/application'
 
module RouteScoper
  # Keep the rescue so that you can revert to not having a
  # subdirectory when in development and test modes
  def self.root
    Rails.application.config.root_directory
  rescue NameError
    '/'
  end
end

Tinyblog::Application.routes.draw do
  scope RouteScoper.root do

    resources :posts

    namespace :admin do
      # resources :users
      resources :posts

      get :login, to: 'sessions#new'
      post :login, to: 'sessions#create'
      delete :logout, to: 'sessions#destroy'
    end

    root 'posts#index'
  end
end
