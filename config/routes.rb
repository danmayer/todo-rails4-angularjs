Todo::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  namespace :api, defaults: {format: :json} do
    devise_scope :user do
      post 'registrations' => 'registrations#create', :as => 'register'
      resource :session, only: [:create, :destroy]
    end
    
    resources :destinations, only: [:index, :show] do
    end
    
    resources :trips, only: [:index, :create, :update, :destroy, :show] do
      resources :costs, only: [:index, :create, :update, :destroy]
      resources :trip_destinations, only: [:index, :create, :update, :destroy]
    end
    
    resources :task_lists, only: [:index, :create, :update, :destroy, :show] do
      resources :tasks, only: [:index, :create, :update, :destroy]
    end
  end

  root :to => "home#index"

  get '/calc' => "home#calculator"
  get '/dashboard' => 'templates#index'
  get '/task_lists/:id' => 'templates#index'
  get '/trips/:id' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }
end
