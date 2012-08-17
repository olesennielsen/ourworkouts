Ourworkouts::Application.routes.draw do
  resources :events

  resources :event_messages

  resources :discussions

  resources :groups

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
end
