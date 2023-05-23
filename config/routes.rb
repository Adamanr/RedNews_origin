Rails.application.routes.draw do
  resources :editions
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users do
    member do
      post 'subscribe', to: 'subscriptions#create'
      delete 'unsubscribe', to: 'subscriptions#destroy'
    end
  end


  resources :articles do
    post 'create_comment', on: :member
    member do
      post 'like'
      get 'like'
    end
  end

  resources :events do
    resource :event_bookmark, only: [:create, :destroy]
    post 'create_comment', on: :member
  end

  get '/admin', to: 'admins#index'
  get '/admin/submit/:id', to: 'admins#submit'
  get '/admin/delete/:id', to: 'admins#delete'

  get '/articles_get', to: 'users#articles'
  get '/updates_get', to: 'users#news'

  get '/users/:id', to: 'users#profile'
  get '/users/:id/lenta', to: 'users#lenta'
  get '/all/users', to: 'users#users'

  get '/editions', to: 'editions#index'
  get '/editions', to: 'editions#new'
  get '/editions/:id/users', to: 'editions#user_list'
  get '/editions/sub/:edition_id/:user_id', to: 'editions#subscribe'
  get '/editions/unsub/:edition_id/:user_id', to: 'editions#unsubscribe'

  get '/article', to: 'articles#index'
  get '/articles/tag/:tag', to: 'articles#tag'
  get '/article/find', to: 'articles#find'
  get '/article/selected', to: 'articles#selected'

  get '/news', to: 'events#index'
  get '/news/find/all', to: 'events#find'

  get '/news/:id', to: 'events#show'
  get '/news/category/:category', to: 'events#category'
  get '/news/city/:name', to: 'events#city'
  get '/news/find/:search', to: 'events#find'

  root 'mains#index'
end
