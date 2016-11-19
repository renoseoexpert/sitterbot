Rails.application.routes.draw do
  root to: 'static_pages#root'
  [
    'contact',
    'start',
    'welcome',
    'terms',
    'privacy'
  ].each do |action|
    get "/#{ action }", to: "static_pages##{ action }"
  end

  get '/logout', to: 'sessions#destroy'

  resource :user
  resource :session
  resource :password_reset
  resource :subscription
  resources :kids
  resources :sitters
  resources :events
  resources :subscriptions

  # This is for lets encrypt for https
  get '/.well-known/acme-challenge/:id' => 'static_pages#letsencrypt'
end
