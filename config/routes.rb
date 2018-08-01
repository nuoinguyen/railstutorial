Rails.application.routes.draw do
    # root 'home#index'
    root controller: :home, action: :index
    
    namespace :pages do
        resource :about, controller: :about, only: [:index] do
            collection do
                get :index
            end
        end
        resource :contact, controller: :contact, only: [:index] do
            collection do
                get :index
            end
        end

        # get 'contact/index'
        # get 'about/index'
    end

    # get 'sessions/new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    
    resources :users do
        member do
            get :following, :followers
        end
    end
    
    resources :account_activations, only: [:edit]

    # get 'password_resers/new'
    # get 'password_resers/edit'
    resources :password_resets,     only: [:new, :create, :edit, :update]

    resources :microposts,          only: [:create, :destroy]

    resources :relationships,       only: [:create, :destroy]
    
end
