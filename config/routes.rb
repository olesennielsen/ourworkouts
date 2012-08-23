Ourworkouts::Application.routes.draw do

  devise_for :users

  resources :users, :only => [:show, :index]

  resources :events

  resources :discussion_messages

  resources :event_messages

  resources :discussions

  resources :groups

  resources :direct_messages

  authenticated :user do
    root :to => 'users#show'
  end
  
  root :to => "home#index"

end
