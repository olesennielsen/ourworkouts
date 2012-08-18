Ourworkouts::Application.routes.draw do
  resources :events

  resources :discussion_messages

  resources :event_messages

  resources :discussions

  resources :groups
  resources :direct_messages
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]
end
