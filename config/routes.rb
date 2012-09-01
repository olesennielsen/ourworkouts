Ourworkouts::Application.routes.draw do

  resources :events

  resources :discussion_messages

  resources :event_messages

  resources :discussions

  resources :groups

  resources :direct_messages

  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } #do
  #    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
  #    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end

  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  end
  
  
  authenticated :user do
    root :to => 'users#show'
  end

  root :to => "home#index"

end
