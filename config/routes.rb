Rails.application.routes.draw do
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

        # resource :about
        # get 'contact/index'
        # get 'about/index'
    end
    # get 'home/index'

    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    # get 'sessions/new'
    resources :users
    resource :account_activations, only: [:edit]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
