Ourworkouts::Application.routes.draw do

  resources :events

  resources :discussion_messages

  resources :event_messages

  resources :discussions

  resources :groups

  resources :direct_messages

  get '/sign_up' => "home#sign_up"
  get '/who' => "home#who"
  get '/what' => "home#what"
  get '/how' => "home#how"
  get '/workout_tips' => "home#workout_tips"
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } #do
  #    get 'sign_in', :to => 'users/sessions#new', :as => :new_user_session
  #    get 'sign_out', :to => 'users/sessions#destroy', :as => :destroy_user_session
  # end

  devise_scope :user do
    get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    get '/email_sign_up' => "users/omniauth_callbacks#email"
  end  
  
  authenticated :user do
    root :to => 'home#dashboard'
  end

  root :to => "home#index"

end
