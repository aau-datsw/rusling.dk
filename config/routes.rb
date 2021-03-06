Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  namespace :api do
    constraints subdomain: 'api' do
      resources :matches
    end
  end

  # Authentication
  get '/login', to: 'public/sessions#new'
  get '/logout', to: 'public/sessions#destroy'
  match '/auth/:provider/callback', to: 'public/sessions#create', as: :auth_login_callback, via: %i[get post]

  # Events
  get '/events/', to: 'public/events#index', as: :events
  get '/events/:id', to: 'public/events#show', as: :event

  # Dynamic page-matching
  match '/:slug', to: 'public/pages#show',
                  via: :get,
                  constraints: ->(r) { Page.where(slug: r.params[:slug]).exists? }

  root to: 'public/pages#show'
end
